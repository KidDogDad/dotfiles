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

--- Tab settings ---
-- Hide tab bar if only one tab
config.hide_tab_bar_if_only_one_tab = true

-- Place tab bar at bottom
config.tab_bar_at_bottom = true

-- Retro style tab
config.use_fancy_tab_bar = false

config.colors = {
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = "#0b0022",

		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#c6a0f6",
			-- The color of the text for the tab
			fg_color = "#181926",

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Normal",

			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "None",

			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab.  The default is false.
			italic = false,

			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#363a4f",
			fg_color = "#8aadf4",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		-- inactive_tab_hover = {
		--   bg_color = '#3b3052',
		--   fg_color = '#909090',
		--   italic = true,

		-- The same options that were listed under the `active_tab` section above
		-- can also be used for `inactive_tab_hover`.
		-- },

		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#1b1032",
			fg_color = "#808080",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#3b3052",
			fg_color = "#909090",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}

-- Trying tabline.wez
--local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- tabline.setup({
-- options = {
-- icons_enabled = true,
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
-- 		tabline_a = { "mode" },
-- 		tabline_b = { "workspace" },
-- 		tabline_c = { " " },
-- 		tab_active = {
-- 			"index",
-- 			{ "parent", padding = 0 },
-- 			"/",
-- 			{ "cwd", padding = { left = 0, right = 1 } },
-- 			{ "zoomed", padding = 0 },
-- 		},
-- 		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
-- 		tabline_x = { "ram", "cpu" },
-- 		tabline_y = { "datetime", "battery" },
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
-- config.status_update_interval = 500

------------------------

-- Finally, return the configuration to wezterm:
return config
