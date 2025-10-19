local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

local is_darwin = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

if is_darwin() then
	config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
end

config.window_decorations = "RESIZE"

config.color_scheme = 'Kanagawa (Gogh)'

config.window_background_opacity = is_darwin() and 0.85 or 0.95

config.font_size = is_darwin() and 14 or 11

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

return config
