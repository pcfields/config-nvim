local wezterm = require("wezterm") -- Pull in the wezterm API
local mux = wezterm.mux

local config = {} -- This table will hold the configuration.

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- https://www.florianbellmann.com/blog/switch-from-tmux-to-wezterm
	-- split Vertical
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- split Horizontal
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Maximize pane
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- rotate panes
	{
		mods = "LEADER",
		key = "r",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	-- show the pane selection mode, but have it swap the active and selected panes
	{
		mods = "LEADER",
		key = "0",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	-- activate copy mode or vim mode
	{
		mods = "LEADER",
		key = "Enter",
		action = wezterm.action.ActivateCopyMode,
	},
	-- Switch workspaces
	{
		mods = "LEADER",
		key = "W",
		action = wezterm.action.SwitchToWorkspace,
		name = "webapp-coding",
	},
	{
		key = "9",
		mods = "ALT",
		action = wezterm.action.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
}
config.color_scheme = "AdventureTime"
config.default_cwd = "C:\\Projects\\gliderbim.webapp\\GliderBim.WebApp"
config.default_prog = { "pwsh.exe" } -- Use powershell as the default
config.window_decorations = "RESIZE|TITLE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- RIGHT STATUS
-- wezterm.on("update-right-status", function(window, pane)
-- 	-- "Wed Mar 3 08:14"
-- 	local date = wezterm.strftime("%a %b %-d %H:%M ")

-- 	local bat = ""
-- 	for _, b in ipairs(wezterm.battery_info()) do
-- 		bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
-- 	end

-- 	window:set_right_status(wezterm.format({
-- 		{ Text = bat .. "   " .. date },
-- 	}))
-- end)

--- GUI STARTUP
-- wezterm.on("gui-startup", function(cmd)
-- 	local screen = wezterm.gui.screens().active
-- 	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
-- 	local gui = window:gui_window()
-- 	local width = 0.7 * screen.width
-- 	local height = 0.9 * screen.height

-- 	gui:set_inner_size(width, height)

-- 	local position_x = (screen.width - width)
-- 	local position_y = (screen.height - height) / 2
-- 	gui:set_position(position_x, position_y)
-- end)

--- GUI STARTUP
-- Use split window by default
wezterm.on("gui-startup", function(cmd)
	-- allow `wezterm start -- something` to affect what we spawn
	-- in our initial Windows
	local args = {}
	if cmd then
		args = cmd.args
	end

	-- Set a workspace for coding
	local webapp_dir = "C:\\Projects\\gliderbim.webapp\\GliderBim.WebApp"

	local tab, terminal_pane, window = mux.spawn_window({
		workspace = "webapp-coding",
		cwd = webapp_dir,
		args = { "pwsh.exe" },
		color_scheme = "Batman",
		-- size = 0.1,
	})

	window:gui_window():maximize()

	tab:set_title("Webapp")

	local editor_pane = terminal_pane:split({
		direction = "Right",
		size = 0.9,
		cwd = webapp_dir,
	})

	editor_pane:send_paste("nvim .\n")
	terminal_pane:send_paste("npm run test:watch")

	--
	local tab, pane, window = mux.spawn_window({
		workspace = "",
		args = { "ssh", "vault" },
	})
	-- mux.set_active_workspace("webapp-coding")
end)

-- and finally, return the configuration to wezterm
return config
