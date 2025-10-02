local wezterm = require("wezterm") -- Pull in the wezterm API
local working_dir = wezterm.home_dir
local color_schemes = { Adventure = "Adventure", Abernathy = "Abernathy", Argonaut = "Argonaut" }
local windows_platform = "x86_64-pc-windows-msvc"
local os_shell = "/home/linuxbrew/.linuxbrew/bin/fish"

local config = {} -- This table will hold the configuration.

-- Config Helper Functions ___________________________________________________
local function is_windows_platform()
	return wezterm.target_triple == windows_platform
end

if is_windows_platform() then
	os_shell = "pwsh.exe"
end

local function resize_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize({ direction, 3 }),
	}
end

local function split_pane(key, direction)
	return {
		key = key,
		action = wezterm.action.SplitPane({ direction = direction, size = { Percent = 30 } }),
	}
end

local function go_to_tab(tab_number)
	local zero_index_tab = tab_number - 1

	return {
		mods = "LEADER",
		key = tostring(tab_number),
		action = wezterm.action.ActivateTab(zero_index_tab),
	}
end

local projects_root = {
	work = "C:/Projects",
	personal = wezterm.home_dir .. "/ws",
}

-- ============================================================================
-- WORK-SPECIFIC CONFIGURATION
-- ============================================================================
local work_config = {
	projects = {
		{
			path = "C:/Projects/gliderbim.webapp/GliderBim.WebApp",
			label = "GliderBim WebApp",
		},
		-- Add more work projects here as needed
		-- {
		--   path = "C:/Projects/another-project",
		--   label = "Another Project",
		-- },
	},
	exclude_from_glob = {
		"C:/Projects/gliderbim.webapp", -- Exclude parent folder since we use the inner path
	},
}

-- ============================================================================
-- PERSONAL-SPECIFIC CONFIGURATION
-- ============================================================================
local personal_config = {
	project_folders = { "apps", "learn", "pcfields", "clients" },
	-- Add specific personal projects here if needed
	projects = {
		-- {
		--   path = wezterm.home_dir .. "/ws/special-project",
		--   label = "Special Project",
		-- },
	},
}

-- ============================================================================
-- SHARED CONFIGURATION (Platform-agnostic)
-- ============================================================================
local shared_config = {
	nvim = function()
		if is_windows_platform() then
			return os.getenv("LOCALAPPDATA") .. "/nvim"
		else
			return wezterm.home_dir .. "/.config/nvim"
		end
	end,
}

-- ============================================================================
-- PROJECT UTILITIES MODULE
-- ============================================================================

local project_utils = {}

project_utils.is_folder = function(path)
	-- Use WezTerm's read_dir to check if path is actually a directory
	local success, _ = pcall(wezterm.read_dir, path)
	return success
end

project_utils.normalize_path = function(path)
	-- Normalize path separators and case for comparison
	return path:gsub("\\", "/"):lower()
end

project_utils.add_paths_to_list = function(projects_list, options)
	local exclude_list = options.exclude or {}

	for _, project_directory in ipairs(options.directories) do
		local folder_name = project_directory:match("([^/\\]+)$") -- Handle both / and \ separators

		-- Check if this path should be excluded (normalize for comparison)
		local should_exclude = false
		local normalized_project = project_utils.normalize_path(project_directory)
		for _, excluded_path in ipairs(exclude_list) do
			if normalized_project == project_utils.normalize_path(excluded_path) then
				should_exclude = true
				break
			end
		end

		-- Only add if it's actually a directory and not excluded
		if project_utils.is_folder(project_directory) and not should_exclude then
			table.insert(projects_list, { id = project_directory, label = folder_name })
		end
	end
end

local function add_subdirectories_for(root_directory)
	local sub_directories = {}
	local directories_under_root_directory = wezterm.glob(root_directory .. "/*")

	for _, sub_directory in ipairs(directories_under_root_directory) do
		table.insert(sub_directories, sub_directory)
	end

	return sub_directories
end

-- ============================================================================
-- WORK PROJECT SETUP
-- ============================================================================

local function setup_work_projects(projects_list)
	-- Add Neovim config first (shared)
	table.insert(projects_list, { id = shared_config.nvim(), label = "Neovim Config" })

	-- Add manually configured work projects (priority items at top)
	for _, project in ipairs(work_config.projects) do
		table.insert(projects_list, { id = project.path, label = project.label })
	end

	-- Add all other work subdirectories from glob (excluding manual ones)
	project_utils.add_paths_to_list(projects_list, {
		directories = add_subdirectories_for(projects_root.work),
		exclude = work_config.exclude_from_glob,
	})
end

-- ============================================================================
-- PERSONAL PROJECT SETUP
-- ============================================================================

local function setup_personal_projects(projects_list)
	-- Add Neovim config first (shared)
	table.insert(projects_list, { id = shared_config.nvim(), label = "Neovim Config" })

	-- Add manually configured personal projects (priority items)
	for _, project in ipairs(personal_config.projects) do
		table.insert(projects_list, { id = project.path, label = project.label })
	end

	-- Add subdirectories from personal project folders
	for _, folder_name in ipairs(personal_config.project_folders) do
		local project_path = projects_root.personal .. "/" .. folder_name
		project_utils.add_paths_to_list(projects_list, {
			directories = add_subdirectories_for(project_path),
		})
	end
end

-- ============================================================================
-- PROJECT LIST DISPLAY
-- ============================================================================

local function display_project_list()
	local projects_list = {}

	-- Dispatch to appropriate setup function based on platform
	if is_windows_platform() then
		setup_work_projects(projects_list)
	else
		setup_personal_projects(projects_list)
	end

	return wezterm.action.InputSelector({
		title = "Choose a project",
		choices = projects_list,
		fuzzy = true,
		action = wezterm.action_callback(function(child_window, child_pane, id, label)
			if not label then
				return
			end

			local directory_name = label:match("([^/]+)$") -- get last segment of directory path

			child_window:perform_action(
				wezterm.action.SwitchToWorkspace({
					name = directory_name,
					spawn = { label = "Workspace: " .. label, cwd = id },
				}),
				child_pane
			)
		end),
	})
end

-- CONFIG ___________________________________________________
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.6,
}
-- This is where you actually apply your config choices
config.color_scheme = color_schemes.Abernathy
config.default_cwd = working_dir
config.default_prog = { os_shell }
config.window_decorations = "RESIZE|TITLE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.hide_tab_bar_if_only_one_tab = false
config.window_background_opacity = 1

-- These are supposed to improve performance
config.max_fps = 120
config.animation_fps = 120
config.front_end = "WebGpu"
config.prefer_egl = true
------
---
local dont_use_font_ligatures = { "calt=0", "clig=0", "liga=0" }

config.warn_about_missing_glyphs = false
config.font_size = 10.0
config.font = wezterm.font_with_fallback({
	{
		family = "Monaspace Neon",
		weight = "Light",
		harfbuzz_features = dont_use_font_ligatures,
	},
	{
		family = "JetBrains Mono",
		weight = "Regular",
		harfbuzz_features = dont_use_font_ligatures,
	},
})

config.mouse_bindings = {
	-- Change the default click behavior so that it only selects
	-- text and doesn't open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.CompleteSelection("ClipboardAndPrimarySelection"),
	},

	-- Bind 'Up' event of CTRL-Click to open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
	-- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.Nop,
	},
}

--https://alexplescan.com/posts/2024/08/10/wezterm/
config.key_tables = {
	resize_panes = {
		resize_pane("j", "Down"),
		resize_pane("k", "Up"),
		resize_pane("h", "Left"),
		resize_pane("l", "Right"),
	},
	split_panes = {
		split_pane("j", "Down"),
		split_pane("k", "Up"),
		split_pane("h", "Left"),
		split_pane("l", "Right"),
	},
}

config.leader = {
	key = "Space",
	mods = "SHIFT",
	timeout_milliseconds = 2000,
}
-- https://www.florianbellmann.com/blog/switch-from-tmux-to-wezterm
config.keys = {
	{ -- display list of projects
		mods = "LEADER",
		key = "p",
		action = display_project_list(),
	},
	{ -- Open lazygit in new tab
		mods = "LEADER",
		key = "g",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { os_shell, "-c", 'lazygit || read -p "Press enter to exit..."' },
		}),
	},
	{ -- Open Opencode AI in new tab
		mods = "LEADER",
		key = ".",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { os_shell, "-c", 'opencode || read -p "Press enter to exit..."' },
		}),
	},
	{ -- display list of workspaces
		mods = "LEADER",
		key = "w",
		action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
	{ -- [s]plit pane <leader> s + [ h,j,k,l ]
		mods = "LEADER",
		key = "s",
		action = wezterm.action.ActivateKeyTable({
			name = "split_panes", -- same name as in the `config.key_tables`
			one_shot = false,   -- Ensures the keytable stays active after it handles its first keypress.
			timeout_milliseconds = 1000, -- deactivate key table after timeout
		}),
	},
	{ -- [m]aximize pane
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},
	{ -- rotate panes swap
		mods = "LEADER",
		key = "n",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	{ -- show the pane selection mode SWAP,
		mods = "LEADER",
		key = "v",
		action = wezterm.action.PaneSelect({ mode = "Activate" }),
	},
	{ -- activate copy mode or vim mode
		mods = "LEADER",
		key = "y",
		action = wezterm.action.ActivateCopyMode,
	},
	{ -- create new tab
		mods = "LEADER",
		key = "a",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{ -- delete tab
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{ -- go the next tab
		mods = "LEADER",
		key = "o",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{ -- go to previous tab
		mods = "LEADER",
		key = "i",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{ -- go to left pane
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{ -- go to bottom pane
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{ -- go to top pane
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{ -- go to right pane
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{ -- [r]esize panes <leader> r + [ h,j,k,l ]
		mods = "LEADER",
		key = "r",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes", -- same name as in the `config.key_tables`
			one_shot = false,   -- Ensures the keytable stays active after it handles its first keypress.
			timeout_milliseconds = 1000, -- deactivate key table after timeout
		}),
	},
	-- Go to specific tab <leader> number
	go_to_tab(1),
	go_to_tab(2),
	go_to_tab(3),
	go_to_tab(4),
	go_to_tab(5),
	go_to_tab(6),
	{ -- scroll up by page
		mods = "LEADER",
		key = "u",
		action = wezterm.action.ScrollByPage(-1),
	},
	{ -- scroll down by page
		mods = "LEADER",
		key = "d",
		action = wezterm.action.ScrollByPage(1),
	},
}

-- RIGHT STATUS
wezterm.on("update-right-status", function(window)
	local black = wezterm.color.parse("#000")
	local white = wezterm.color.parse("#fff")

	local workspace_section = {
		{ Foreground = { Color = white } },
		{ Text = "  " .. " " },
		{ Background = { Color = white } },
		{ Foreground = { Color = black } },
		{ Text = "  " .. window:mux_window():get_workspace() .. "  " },
		{ Background = { Color = black } },
		{ Foreground = { Color = white } },
		{ Text = " " },
	}

	window:set_right_status(wezterm.format(workspace_section))

	-- Show leader key active status
	local prefix = ""
	if window:leader_is_active() then
		prefix = " ️️🔴🔴🔴⭕⭕⭕"
	end

	window:set_left_status(wezterm.format({
		{ Text = prefix },
	}))
end)

return config
