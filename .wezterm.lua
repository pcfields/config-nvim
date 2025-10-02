local wezterm = require("wezterm")

local config = {} -- This table will hold the configuration.

-- ============================================================================
-- PLATFORM MODULE
-- ============================================================================

local platform = {
	is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc",
}

platform.shell = platform.is_windows and "pwsh.exe" or "/home/linuxbrew/.linuxbrew/bin/fish"

platform.home_dir = wezterm.home_dir

-- ============================================================================
-- KEYMAP BUILDERS MODULE
-- ============================================================================

local keymap_builders = {}

keymap_builders.resize_pane = function(key, direction)
	return {
		key = key,
		action = wezterm.action.AdjustPaneSize({ direction, 3 }),
	}
end

keymap_builders.split_pane = function(key, direction)
	return {
		key = key,
		action = wezterm.action.SplitPane({ direction = direction, size = { Percent = 30 } }),
	}
end

keymap_builders.go_to_tab = function(tab_number)
	return {
		mods = "LEADER",
		key = tostring(tab_number),
		action = wezterm.action.ActivateTab(tab_number - 1),
	}
end

-- ============================================================================
-- COMMAND SPAWNERS MODULE
-- ============================================================================

local command_spawners = {}

command_spawners.lazygit = function()
	return wezterm.action.SpawnCommandInNewTab({
		args = { platform.shell, "-c", 'lazygit || read -p "Press enter to exit..."' },
	})
end

command_spawners.opencode = function()
	return wezterm.action.SpawnCommandInNewTab({
		args = { platform.shell, "-c", 'opencode || read -p "Press enter to exit..."' },
	})
end

-- ============================================================================
-- UI CONFIGURATION MODULE
-- ============================================================================

local ui_config = {
	color_scheme = "Abernathy",
	font_size = 10.0,
	font_config = {
		primary = { family = "Monaspace Neon", weight = "Light" },
		fallback = { family = "JetBrains Mono", weight = "Regular" },
		disable_ligatures = { "calt=0", "clig=0", "liga=0" },
	},
	window = {
		decorations = "RESIZE|TITLE",
		padding = { left = 0, right = 0, top = 0, bottom = 0 },
		background_opacity = 1,
	},
	tabs = {
		hide_if_only_one = false,
	},
	panes = {
		inactive_hsb = { saturation = 0.9, brightness = 0.6 },
	},
}

-- ============================================================================
-- PERFORMANCE CONFIGURATION MODULE
-- ============================================================================

local performance_config = {
	max_fps = 120,
	animation_fps = 120,
	front_end = "WebGpu",
	prefer_egl = true,
}

-- ============================================================================
-- PROJECT ROOTS
-- ============================================================================

local projects_root = {
	work = "C:/Projects",
	personal = platform.home_dir .. "/ws",
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
		if platform.is_windows then
			return os.getenv("LOCALAPPDATA") .. "/nvim"
		else
			return platform.home_dir .. "/.config/nvim"
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
	if platform.is_windows then
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

-- ============================================================================
-- APPLY CONFIGURATION
-- ============================================================================

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Shell and Working Directory
config.default_cwd = platform.home_dir
config.default_prog = { platform.shell }

-- UI Settings
config.color_scheme = ui_config.color_scheme
config.font_size = ui_config.font_size
config.font = wezterm.font_with_fallback({
	{
		family = ui_config.font_config.primary.family,
		weight = ui_config.font_config.primary.weight,
		harfbuzz_features = ui_config.font_config.disable_ligatures,
	},
	{
		family = ui_config.font_config.fallback.family,
		weight = ui_config.font_config.fallback.weight,
		harfbuzz_features = ui_config.font_config.disable_ligatures,
	},
})
config.warn_about_missing_glyphs = false
config.window_decorations = ui_config.window.decorations
config.window_padding = ui_config.window.padding
config.window_background_opacity = ui_config.window.background_opacity
config.hide_tab_bar_if_only_one_tab = ui_config.tabs.hide_if_only_one
config.inactive_pane_hsb = ui_config.panes.inactive_hsb

-- Performance Settings
config.max_fps = performance_config.max_fps
config.animation_fps = performance_config.animation_fps
config.front_end = performance_config.front_end
config.prefer_egl = performance_config.prefer_egl

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

-- Key Tables
config.key_tables = {
	resize_panes = {
		keymap_builders.resize_pane("j", "Down"),
		keymap_builders.resize_pane("k", "Up"),
		keymap_builders.resize_pane("h", "Left"),
		keymap_builders.resize_pane("l", "Right"),
	},
	split_panes = {
		keymap_builders.split_pane("j", "Down"),
		keymap_builders.split_pane("k", "Up"),
		keymap_builders.split_pane("h", "Left"),
		keymap_builders.split_pane("l", "Right"),
	},
}

config.leader = {
	key = "Space",
	mods = "SHIFT",
	timeout_milliseconds = 2000,
}

-- Keybindings
config.keys = {
	-- Projects and Tools
	{ mods = "LEADER", key = "p", action = display_project_list() },
	{ mods = "LEADER", key = "g", action = command_spawners.lazygit() },
	{ mods = "LEADER", key = ".", action = command_spawners.opencode() },
	{ mods = "LEADER", key = "w", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

	-- Pane Management
	{ -- [s]plit pane
		mods = "LEADER",
		key = "s",
		action = wezterm.action.ActivateKeyTable({
			name = "split_panes",
			one_shot = false,
			timeout_milliseconds = 1000,
		}),
	},
	{ mods = "LEADER", key = "m", action = wezterm.action.TogglePaneZoomState },
	{ mods = "LEADER", key = "n", action = wezterm.action.RotatePanes("Clockwise") },
	{ mods = "LEADER", key = "v", action = wezterm.action.PaneSelect({ mode = "Activate" }) },
	{ mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
	{ mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
	{ mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
	{ mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
	{ -- [r]esize panes
		mods = "LEADER",
		key = "r",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_panes",
			one_shot = false,
			timeout_milliseconds = 1000,
		}),
	},

	-- Tab Management
	{ mods = "LEADER", key = "a", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ mods = "LEADER", key = "o", action = wezterm.action.ActivateTabRelative(1) },
	{ mods = "LEADER", key = "i", action = wezterm.action.ActivateTabRelative(-1) },
	keymap_builders.go_to_tab(1),
	keymap_builders.go_to_tab(2),
	keymap_builders.go_to_tab(3),
	keymap_builders.go_to_tab(4),
	keymap_builders.go_to_tab(5),
	keymap_builders.go_to_tab(6),

	-- Copy Mode and Scrolling
	{ mods = "LEADER", key = "y", action = wezterm.action.ActivateCopyMode },
	{ mods = "LEADER", key = "u", action = wezterm.action.ScrollByPage(-1) },
	{ mods = "LEADER", key = "d", action = wezterm.action.ScrollByPage(1) },
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
