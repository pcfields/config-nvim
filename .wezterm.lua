local wezterm = require 'wezterm' -- Pull in the wezterm API
local working_dir = wezterm.home_dir
local color_schemes = { Adventure = 'Adventure', Abernathy = 'Abernathy', Argonaut = 'Argonaut' }
local windows_platform = 'x86_64-pc-windows-msvc'
local os_shell = 'bash'

local config = {} -- This table will hold the configuration.

-- Config Helper Functions ___________________________________________________
local function is_windows_platform()
    return wezterm.target_triple == windows_platform
end

if is_windows_platform() then
    os_shell = 'pwsh.exe'
end

local function resize_pane(key, direction)
    return {
        key = key,
        action = wezterm.action.AdjustPaneSize { direction, 3 },
    }
end

local function split_pane(key, direction)
    return {
        key = key,
        action = wezterm.action.SplitPane { direction = direction, size = { Percent = 30 } },
    }
end

local function go_to_tab(tab_number)
    local zero_index_tab = tab_number - 1

    return {
        mods = 'LEADER',
        key = tostring(tab_number),
        action = wezterm.action.ActivateTab(zero_index_tab),
    }
end

local projects_root = {
    work = 'C:/Projects',
    personal = wezterm.home_dir .. '/ws',
}

local function project_list(root_dir)
    local project_dirs = {}
    local sub_dirs = wezterm.glob(root_dir .. '/*')

    for _, sub_dir in ipairs(sub_dirs) do
        table.insert(project_dirs, sub_dir)
    end

    return project_dirs
end

local function choose_project()
    local projects = {}
    local work_nvim_dir = 'C:/Users/PeterFields/AppData/Local/nvim'
    local work_webapp_frontend_dir = 'C:/Projects/gliderbim.webapp/GliderBim.WebApp'
    local work_projects = { work_webapp_frontend_dir, work_nvim_dir }

    for _, dir_path in ipairs(project_list(projects_root.work)) do
        table.insert(work_projects, dir_path)
    end

    local personal_projects = {
        apps = project_list(projects_root.personal .. '/apps'),
        learn = project_list(projects_root.personal .. '/learn'),
        pcfields = project_list(projects_root.personal .. '/pcfields'),
        clients = project_list(projects_root.personal .. '/clients'),
    }

    local function is_folder(path)
        local length = #path
        local index_of_dot_in_name = string.find(path, '%.')

        if index_of_dot_in_name and length - index_of_dot_in_name < 4 then
            return false
        end

        return true
    end

    local function add_projects(project_dirs)
        for _, project_dir in ipairs(project_dirs) do
            local remove_from_path = wezterm.home_dir
            local folder_name = string.gsub(project_dir, remove_from_path, '')

            folder_name = string.gsub(project_dir, projects_root.work, '')

            if is_folder(folder_name) then
                table.insert(projects, { id = project_dir, label = folder_name })
            end
        end
    end

    if is_windows_platform() then
        table.insert(projects, { id = work_webapp_frontend_dir, label = 'Webapp Frontend' })
        table.insert(projects, { id = work_nvim_dir, label = 'Neovim Config' })
    else
        for _, project_dir_list in pairs(personal_projects) do
            add_projects(project_dir_list)
        end
    end

    return wezterm.action.InputSelector {
        title = 'Choose a project',
        choices = projects,
        fuzzy = true,
        action = wezterm.action_callback(function(child_window, child_pane, id, label)
            if not label then
                return
            end

            local directory_name = label:match '([^/]+)$' -- get last segment of directory path

            child_window:perform_action(
                wezterm.action.SwitchToWorkspace {
                    name = directory_name,
                    spawn = { label = 'Workspace: ' .. label, cwd = id },
                },
                child_pane
            )
        end),
    }
end

-- CONFIG ___________________________________________________
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.color_scheme = color_schemes.Abernathy
config.default_cwd = working_dir
config.default_prog = { os_shell }
config.window_decorations = 'RESIZE|TITLE'
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.hide_tab_bar_if_only_one_tab = false
config.window_background_opacity = 0.9
config.font_size = 11.0
config.font = wezterm.font {
    family = 'JetBrains Mono',
    weight = 'Regular',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- don't use font ligatures
}
--https://alexplescan.com/posts/2024/08/10/wezterm/
config.key_tables = {
    resize_panes = {
        resize_pane('j', 'Down'),
        resize_pane('k', 'Up'),
        resize_pane('h', 'Left'),
        resize_pane('l', 'Right'),
    },
    split_panes = {
        split_pane('j', 'Down'),
        split_pane('k', 'Up'),
        split_pane('h', 'Left'),
        split_pane('l', 'Right'),
    },
}

config.leader = {
    key = 'Space',
    mods = 'SHIFT',
    timeout_milliseconds = 2000,
}
-- https://www.florianbellmann.com/blog/switch-from-tmux-to-wezterm
config.keys = {
    { -- display list of projects
        mods = 'LEADER',
        key = 'p',
        action = choose_project(),
    },
    { -- Open lazygit in new tab
        mods = 'LEADER',
        key = 'g',
        action = wezterm.action.SpawnCommandInNewTab {
            args = { os_shell, '-c', 'lazygit || read -p "Press enter to exit..."' },
        },
    },
    { -- display list of workspaces
        mods = 'LEADER',
        key = 'w',
        action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    { -- [s]plit pane <leader> s + [ h,j,k,l ]
        mods = 'LEADER',
        key = 's',
        action = wezterm.action.ActivateKeyTable {
            name = 'split_panes',        -- same name as in the `config.key_tables`
            one_shot = false,            -- Ensures the keytable stays active after it handles its first keypress.
            timeout_milliseconds = 1000, -- deactivate key table after timeout
        },
    },
    { -- [m]aximize pane
        mods = 'LEADER',
        key = 'm',
        action = wezterm.action.TogglePaneZoomState,
    },
    { -- rotate panes swap
        mods = 'LEADER',
        key = 'n',
        action = wezterm.action.RotatePanes 'Clockwise',
    },
    { -- show the pane selection mode SWAP,
        mods = 'LEADER',
        key = 'v',
        action = wezterm.action.PaneSelect { mode = 'Activate' },
    },
    { -- activate copy mode or vim mode
        mods = 'LEADER',
        key = 'y',
        action = wezterm.action.ActivateCopyMode,
    },
    { -- create new tab
        mods = 'LEADER',
        key = 'a',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    { -- delete tab
        mods = 'LEADER',
        key = 'x',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    { -- go the next tab
        mods = 'LEADER',
        key = 'o',
        action = wezterm.action.ActivateTabRelative(1),
    },
    { -- go to previous tab
        mods = 'LEADER',
        key = 'i',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    { -- go to left pane
        mods = 'LEADER',
        key = 'h',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    { -- go to bottom pane
        mods = 'LEADER',
        key = 'j',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    { -- go to top pane
        mods = 'LEADER',
        key = 'k',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    { -- go to right pane
        mods = 'LEADER',
        key = 'l',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    { -- [r]esize panes <leader> r + [ h,j,k,l ]
        mods = 'LEADER',
        key = 'r',
        action = wezterm.action.ActivateKeyTable {
            name = 'resize_panes',       -- same name as in the `config.key_tables`
            one_shot = false,            -- Ensures the keytable stays active after it handles its first keypress.
            timeout_milliseconds = 1000, -- deactivate key table after timeout
        },
    },                                   -- Go to specific tab <leader> number
    go_to_tab(1),
    go_to_tab(2),
    go_to_tab(3),
    go_to_tab(4),
    go_to_tab(5),
    go_to_tab(6),
    { -- scroll up by page
        mods = 'LEADER',
        key = 'u',
        action = wezterm.action.ScrollByPage(-1),
    },
    { -- scroll down by page
        mods = 'LEADER',
        key = 'd',
        action = wezterm.action.ScrollByPage(1),
    },
}


-- RIGHT STATUS
wezterm.on('update-right-status', function(window)
    local LEFT_DIVIDER = ''

    local bg_color = wezterm.color.parse '#373d68'
    local fg_color = wezterm.color.parse '#fff'
    local colors = {
        bg = {
            light = bg_color:lighten(0.1),
            medium = bg_color:darken(0.2),
            dark = bg_color:darken(0.4),
        },
        fg = {
            light = fg_color:darken(0.1),
            medium = fg_color:darken(0.3),
            dark = fg_color:darken(0.4),
        },
    }

    window:set_right_status(wezterm.format {
        -- 1st SECTION Divider
        { Background = { Color = 'none' } },
        { Foreground = { Color = colors.bg.light } },
        { Text = LEFT_DIVIDER },

        -- workspace section
        { Background = { Color = colors.bg.light } },
        { Foreground = { Color = colors.fg.light } },
        { Text = ' ' .. window:mux_window():get_workspace() .. ' ' },

        -- 2nd SECTION Divider
        { Background = { Color = colors.bg.light } },
        { Foreground = { Color = colors.bg.medium } },
        { Text = LEFT_DIVIDER },


        -- 3rd SECTION Divider
        { Background = { Color = colors.bg.medium } },
        { Foreground = { Color = colors.bg.dark } },
        { Text = LEFT_DIVIDER },

    })

    local battery_percentage = function()
        local battery = ''

        for _, b in ipairs(wezterm.battery_info()) do
            local percentage_value = b.state_of_charge * 100
            local percentage = string.format('%.0f%%', percentage_value)

            if percentage_value >= 66 then
                battery = '󱊣' .. percentage
            elseif percentage_value >= 33 then
                battery = '󱊢' .. percentage
            else
                battery = '󱊡' .. percentage
            end
        end

        return battery
    end

    local function battery_percentage_section()
        -- battery section
        return {
            { Background = { Color = colors.bg.medium } },
            { Foreground = { Color = colors.fg.medium } },
            { Text = battery_percentage() .. ' ' },
        }
    end

    local function date_section()
        local date = wezterm.strftime '%b %-d' -- "Wed"
        local day = wezterm.strftime '%a'      -- "Mar 3"
        local time = wezterm.strftime '%H:%M'  -- "08:14"
        -- Date section
        return {
            { Background = { Color = colors.bg.dark } },
            { Foreground = { Color = colors.fg.dark } },
            { Text = ' ' .. day .. ' ' },
            { Text = ' ' .. date .. ' ' },
            { Foreground = { Color = '#b1b1b1' } },
            { Text = ' ' .. time .. '  ' },
        }
    end

    local prefix = ''
    if window:leader_is_active() then
        prefix = ' ️️🔴🔴🔴 '
    end

    window:set_left_status(wezterm.format {
        { Text = prefix },
    })
end)

return config
