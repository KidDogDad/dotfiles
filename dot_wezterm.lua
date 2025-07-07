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
config.color_scheme = "Catppuccin Macchiato"

-- Cursor shape
config.default_cursor_style = 'SteadyBar'

-- Hide tab bar if only one tab
--config.hide_tab_bar_if_only_one_tab = true

-- Place tab bar at bottom
config.tab_bar_at_bottom = true

-- Trying tabline.wez
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Catppuccin Macchiato",
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace" },
		tabline_c = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "ram", "cpu" },
		tabline_y = { "datetime", "battery" },
		tabline_z = { "domain" },
	},
	extensions = {},
})

-- Additional tabline.wez settings
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.status_update_interval = 500

------------------------

-- Finally, return the configuration to wezterm:
return config
