-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

------- My stuff -------

-- Initial geometry for new windows
config.initial_cols = 120
config.initial_rows = 40

-- Font & color scheme
config.font_size = 10
config.font = wezterm.font("Fira Code")
config.color_scheme = "Catppuccin Macchiato"

-- Cursor shape
config.default_cursor_style = "SteadyBar"

------- Fix scroll speed -------

config.mouse_bindings = {
	-- Slower scroll up/down (3 lines instead of Page Up/Down)
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "NONE",
		action = wezterm.action.ScrollByLine(-3),
		alt_screen = false,
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "NONE",
		action = wezterm.action.ScrollByLine(3),
		alt_screen = false,
	},
}

config.enable_scroll_bar = true

config.alternate_buffer_wheel_scroll_speed = 1

------- Tab settings -------

local FORWARD_SLASH = wezterm.nerdfonts.ple_forwardslash_separator

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#0b0022"
	local background = "#1b1032"
	local foreground = "#808080"

	if tab.is_active then
		background = "#2b2042"
		foreground = "#c0c0c0"
	elseif hover then
		background = "#3b3052"
		foreground = "#909090"
	end

	local edge_foreground = background

	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)
-- Hide tab bar if only one tab
config.hide_tab_bar_if_only_one_tab = true

-- Place tab bar at bottom
config.tab_bar_at_bottom = false

-- Retro style tab
config.use_fancy_tab_bar = false

-- Trying tabline.wez
-- local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
--
-- tabline.setup({
-- 	options = {
-- 		icons_enabled = true,
-- 		theme = "Catppuccin Macchiato",
-- 		tabs_enabled = true,
-- 		theme_overrides = {},
-- 		section_separators = {
-- 			left = wezterm.nerdfonts.pl_left_hard_divider,
-- 			right = wezterm.nerdfonts.pl_right_hard_divider,
-- 		},
-- 		component_separators = {
-- 			left = wezterm.nerdfonts.pl_left_soft_divider,
-- 			right = wezterm.nerdfonts.pl_right_soft_divider,
-- 		},
-- 		tab_separators = {
-- 			left = wezterm.nerdfonts.pl_left_hard_divider,
-- 			right = wezterm.nerdfonts.pl_right_hard_divider,
-- 		},
-- 	},
-- 	sections = {
-- 		-- tabline_a = { "mode" },
-- 		-- tabline_b = { "workspace" },
-- 		-- tabline_c = { " " },
-- 		tab_active = {
-- 			"index",
-- 			{ "parent", padding = 0 },
-- 			"/",
-- 			{ "cwd", padding = { left = 0, right = 1 } },
-- 			{ "zoomed", padding = 0 },
-- 		},
-- 		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
-- 		-- tabline_x = { "ram", "cpu" },
-- 		-- tabline_y = { "datetime", "battery" },
-- 		tabline_z = { "domain" },
-- 	},
-- 	extensions = {},
-- })

-- Additional tabline.wez settings
-- config.use_fancy_tab_bar = false
-- config.show_new_tab_button_in_tab_bar = false
-- config.tab_max_width = 32
-- config.window_padding = {
-- 	left = 0,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }
config.status_update_interval = 500

------------------------

-- Finally, return the configuration to wezterm:
return config
