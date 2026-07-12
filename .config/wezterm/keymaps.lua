local M = {}

function M.apply(config, act)
	config.leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 1000 }
	config.keys = {
		{
			key = 'l',
			mods = 'LEADER|CTRL',
			action = act.SendKey({ key = 'l', mods = 'CTRL' }),
		},
		{
			key = '%',
			mods = 'SHIFT|CTRL',
			action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
		},
		{
			key = '"',
			mods = 'SHIFT|CTRL',
			action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
		},
	}
end

return M
