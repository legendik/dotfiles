-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ============================================================================
-- APPEARANCE
-- ============================================================================

-- Font
config.font = wezterm.font("CaskaydiaMono Nerd Font")
config.font_size = 16
config.line_height = 1.0

-- Optional: Disable ligatures to see actual characters (useful for debugging)
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

-- Color scheme
config.color_scheme = "Tokyo Night"

-- Window
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- end)

-- Padding for breathing room
config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

-- ============================================================================
-- TABS & PANES
-- ============================================================================

-- Hide tab bar when only one tab
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- Tab bar style (if you ever use tabs)
config.tab_bar_at_bottom = false
config.show_tab_index_in_tab_bar = true

-- ============================================================================
-- KEYBINDINGS (Vim-style navigation)
-- ============================================================================

local act = wezterm.action

config.keys = {
	-- Split panes
	{
		key = "|",
		mods = "CTRL|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "_",
		mods = "CTRL|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Navigate panes (Vim-style: Ctrl+Shift+hjkl)
	{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },

	-- Resize panes
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },

	-- Close pane
	{ key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },

	-- Toggle pane zoom
	{ key = "z", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },

	-- Create new tab
	{ key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("CurrentPaneDomain") },

	-- Switch tabs
	{ key = "[", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },

	-- Quick tab navigation (Cmd+1-9 on macOS)
	{ key = "1", mods = "CMD", action = act.ActivateTab(0) },
	{ key = "2", mods = "CMD", action = act.ActivateTab(1) },
	{ key = "3", mods = "CMD", action = act.ActivateTab(2) },
	{ key = "4", mods = "CMD", action = act.ActivateTab(3) },
	{ key = "5", mods = "CMD", action = act.ActivateTab(4) },
	{ key = "6", mods = "CMD", action = act.ActivateTab(5) },
	{ key = "7", mods = "CMD", action = act.ActivateTab(6) },
	{ key = "8", mods = "CMD", action = act.ActivateTab(7) },
	{ key = "9", mods = "CMD", action = act.ActivateTab(8) },

	-- Copy/paste (standard macOS)
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
}

-- ============================================================================
-- PERFORMANCE
-- ============================================================================

-- Scrollback
config.scrollback_lines = 10000

-- Performance: only update when needed
config.enable_scroll_bar = false
config.check_for_updates = false

-- ============================================================================
-- SHELL & ENVIRONMENT
-- ============================================================================

-- Optional: Set default shell
-- config.default_prog = { '/bin/zsh', '-l' }

-- Optional: Set environment variables
-- config.set_environment_variables = {
--   PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
-- }

return config
