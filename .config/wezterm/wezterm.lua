local wezterm = require('wezterm')
local config = wezterm.config_builder()
local act = wezterm.action

config.font = wezterm.font('FiraCode Nerd Font')
config.font_size = 13
config.harfbuzz_features =
	{ 'cv02', 'zero', 'ss03', 'cv24', 'ss09', 'cv25', 'cv32', 'ss07' }

require('colors.kanagawa-gh').apply(config)
require('keymaps').apply(config, act)
require('plugins.splits').apply(config, wezterm)

return config
