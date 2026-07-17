# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration (Neovim 0.12+), managed as part of a larger dotfiles repo. Plugins are
managed with the native `vim.pack` plugin manager (Neovim built-in) — **not** lazy.nvim, packer, or any other
third-party manager. Match existing `vim.pack` / stdlib idioms rather than introducing patterns from those tools.

## Commands

- Validate the config loads cleanly: `nvim --headless "+checkhealth" +qa` (or just open `nvim` and check `:messages`
  for startup errors).
- Format a Lua file: `stylua <file>` (no `stylua.toml` in the repo — uses stylua defaults; indentation is tabs).
- Update all plugins to latest revisions: `<leader>U` inside Neovim (calls `vim.pack.update()`), or
  `:lua vim.pack.update()`.
- Remove plugins no longer declared in `init.lua`: `<leader>D` inside Neovim.
- `nvim-pack-lock.json` is the `vim.pack` lockfile (pinned revisions); it's updated automatically by
  `vim.pack.update()` / `vim.pack.add()` — don't hand-edit it.

There is no build step, test suite, or linter for the Lua config itself.

## Architecture

### Startup flow

`init.lua` is the sole entry point. It:
1. Sets core options and disables unused built-in providers/plugins.
2. Registers a `PackChanged` autocmd for post-install/update hooks (e.g. building `telescope-fzf-native.nvim`).
3. Declares plugins via `vim.pack.add` in two groups:
   - `plugins` — loaded eagerly at startup (colorscheme, statusline, LSP config source, etc.).
   - `lazy_plugins` — registered with `{ load = function() end }` (a no-op), so `vim.pack` fetches/tracks them but
     never sources their `plugin/` scripts at startup.

Everything else lives in `plugin/*.lua` (auto-sourced by Neovim at startup, one file per concern) and
`after/ftplugin/*.lua` (auto-sourced per filetype).

### Lazy-loading convention

Because `lazy_plugins` are registered as no-ops, each one is activated on demand from the relevant `plugin/*.lua`
file with `vim.cmd.packadd('<plugin-name>')`, immediately followed by the `require(...)`/`setup(...)` call. The
`packadd` call is gated behind whatever event should trigger loading:
- An autocmd, e.g. `InsertEnter`/`CmdlineEnter` for `blink.cmp` (`plugin/completion.lua`), `BufReadPost`/`BufNewFile`
  for `conform.nvim`, `nvim-lint`, `flash.nvim`, `hlchunk.nvim`, `nvim-dap`, `tree-sitter-manager.nvim`
  (each in its own `plugin/*.lua`).
- A keymap callback, e.g. `telescope.nvim` is only `packadd`-ed the first time a Telescope-bound key is pressed
  (`plugin/telescope.lua`).

When adding a new plugin that should lazy-load, follow this same pattern: add it to `lazy_plugins` in `init.lua`,
then `packadd` + `require`/`setup` it from a new or existing `plugin/*.lua` file behind an autocmd or keymap.
Plugins that must be available immediately (colorscheme, statusline, anything referenced at startup) go in the
eager `plugins` list instead.

### LSP

There is no `lspconfig.setup(...)` call anywhere — `nvim-lspconfig` is only present as a source of default server
configs. LSP servers are enabled per-filetype in `after/ftplugin/<ft>.lua` using the native Neovim LSP client:
```lua
vim.lsp.config.<server> = { ... }   -- only when overriding defaults, e.g. rust_analyzer/hls
vim.lsp.enable('<server>')
vim.treesitter.start()
```
`plugin/lsp.lua` holds the one global `LspAttach` autocmd (buffer-local keymaps like `grd`/`grD`).

### Treesitter

Parser installation is handled by `tree-sitter-manager.nvim` (a minimal installer, not the full `nvim-treesitter`
module) — `ensure_installed` and custom `languages` (e.g. `asciidoc`) are configured in `plugin/treesitter.lua`.
Highlighting is started manually per filetype via `vim.treesitter.start()` in each `after/ftplugin/<ft>.lua`, not
automatically. `nvim-treesitter-textobjects` is set up in the same file and provides the `af`/`if`/`]f`/etc. text
objects and moves.

### Formatting & linting

- `conform.nvim` (`plugin/formatting.lua`): `formatters_by_ft` table, format-on-save with `lsp_fallback = true`.
- `nvim-lint` (`plugin/lint.lua`): runs on `BufWritePost`.

### Other notable files

- `plugin/colors.lua`: kanagawa colorscheme setup (loaded eagerly, `transparent = true`). Do not enable
  kanagawa's `compile = true` — it was tried before and made startup slower.
- `plugin/ai.lua`: opencode.nvim (eager) and copilot.lua (lazy, `packadd`-ed on first `InsertEnter` since its
  server takes a while to start).
- `plugin/keymaps.lua`: general-purpose keymaps not tied to a specific plugin.
- `vim.o.shell` is forced to `/bin/bash` in `init.lua` — fish is the interactive shell but breaks Neovim's
  `!`/`:!` command execution, so don't change this back to fish.
