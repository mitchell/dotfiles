local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local is_darwin = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

config.color_scheme = "GruvboxDark"
config.window_background_opacity = is_darwin() and 0.8 or 0.5
config.window_decorations = "RESIZE"

config.font_size = is_darwin() and 13 or 11

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
	{ key = "Enter", mods = "SHIFT|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "SHIFT|CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "X", mods = "SHIFT|CTRL|ALT", action = act.ActivateCopyMode },
	{ key = "Z", mods = "SHIFT|CTRL|ALT", action = act.TogglePaneZoomState },
	{ key = "H", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "H", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "L", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "L", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "K", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "K", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "J", mods = "SHIFT|CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "J", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
	{ key = "D", mods = "SHIFT|ALT|CTRL", action = act.ShowDebugOverlay },
}

return config
