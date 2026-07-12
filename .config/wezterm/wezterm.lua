local wezterm = require('wezterm')
local config = wezterm.config_builder()
local act = wezterm.action

config.font = wezterm.font('Hack Nerd Font Mono')
config.font_size = 13.0

require('colors.kanagawa-gh').apply(config)
require('keymaps').apply(config, act)
require('plugins.splits').apply(config, wezterm)

return config
