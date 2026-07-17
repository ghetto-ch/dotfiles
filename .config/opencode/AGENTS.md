# Environment

- OS: Arch Linux
- Interactive login shell: fish. opencode's `bash` tool is pinned to `/bin/bash` explicitly (fish's syntax breaks POSIX-style one-liners — same issue was hit and fixed for neovim's `!` command).
- This config directory is git-tracked under `~/dotfiles/.config/opencode` (part of a dotfiles repo). Treat files here as tracked user config, not scratch space.

# What this workspace is used for

opencode here is used for, roughly in order of frequency:

1. Debugging and code generation for small, personal-scale projects (not large production codebases).
2. Shell commands and Linux system administration.
3. Configuring and troubleshooting CLI tools and dotfiles.
4. Neovim plugin development in Lua (plugins/config live under `~/dotfiles/.config/nvim`).

# Working style

- For system administration tasks, be careful with destructive or hard-to-reverse commands (`rm -rf`, `systemctl stop/restart/disable`, package removal, `dd`, force pushes, `git reset --hard`). Several of these are gated to `ask` in `opencode.json` permissions — don't try to route around that gate, and flag risk even for allowed commands when the blast radius is large.
- Prefer small, targeted changes over broad refactors, especially in dotfiles — these are hand-tuned personal configs.
- Local/free models (Ollama cloud, currently `minimax-m3:cloud`) are the default. Paid models via opencode Zen are used deliberately, only when a task needs them — don't assume access to a specific paid model unless told.
