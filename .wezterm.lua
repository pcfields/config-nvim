local wezterm = require 'wezterm' -- Pull in the wezterm API
local mux = wezterm.mux
local working_dir = wezterm.home_dir
local color_schemes = { Adventure = 'Adventure', Abernathy = 'Abernathy', Argonaut = 'Argonaut' }
local webapp_dir = 'C:/Projects/gliderbim.webapp/GliderBim.WebApp'
local windows_platform = 'x86_64-pc-windows-msvc'
local os_shell = 'bash'

local config = {} -- This table will hold the configuration.
-- Config Helper Functions ___________________________________________________
local function is_windows_platform()
    return wezterm.target_triple == windows_platform
end

if is_windows_platform() then
    os_shell = 'pwsh.exe'
    working_dir = webapp_dir
end

local function resize_pane(key, direction)
    return {
        key = key,
        action = wezterm.action.AdjustPaneSize { direction, 3 },
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

local function work_projects()
    local projects = {}
    local sub_directories = wezterm.glob(projects_root.work .. '/*')

    for _, sub_directory in ipairs(sub_directories) do
        table.insert(projects, sub_directory)
    end

    return projects
end

local function choose_project()
    local projects = {}

    for _, project_dir in ipairs(work_projects()) do
        table.insert(projects, { label = project_dir })
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
                    spawn = { cwd = label },
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
config.window_background_opacity = 0.95
config.font = wezterm.font {
    family = 'JetBrains Mono',
    weight = 'Medium',
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
}

config.leader = { key = 'Space', mods = 'SHIFT', timeout_milliseconds = 2000 }
-- https://www.florianbellmann.com/blog/switch-from-tmux-to-wezterm
config.keys = {
    { -- display list of projects
        mods = 'LEADER',
        key = 'p',
        action = choose_project(),
    },
    { -- display list of workspaces
        mods = 'LEADER',
        key = 'f',
        action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    { -- split bottom [v]ertical
        mods = 'LEADER',
        key = 'v',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    { -- split right [s]ide
        mods = 'LEADER',
        key = 's',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
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
        key = 'y',
        action = wezterm.action.PaneSelect { mode = 'Activate' },
    },
    { -- activate copy mode or vim mode
        mods = 'LEADER',
        key = 'Enter',
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
            name = 'resize_panes', -- same name as in the `config.key_tables`
            one_shot = false, -- Ensures the keytable stays active after it handles its first keypress.
            timeout_milliseconds = 1000, -- deactivate key table after timeout
        },
    }, -- Go to specific tab <leader> number
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

-- RIGHT STATUS
wezterm.on('update-right-status', function(window)
    local LEFT_DIVIDER = ''
    local date = wezterm.strftime '%b %-d' -- "Wed"
    local day = wezterm.strftime '%a' -- "Mar 3"
    local time = wezterm.strftime '%H:%M' -- "08:14"
    local bg_color = wezterm.color.parse '#373d68'
    local fg_color = wezterm.color.parse '#fff'
    local colors = {
        bg = {
            light = bg_color:lighten(0.5),
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
        -- battery section
        { Background = { Color = colors.bg.medium } },
        { Foreground = { Color = colors.fg.medium } },
        { Text = battery_percentage() .. ' ' },

        -- 3rd SECTION Divider
        { Background = { Color = colors.bg.medium } },
        { Foreground = { Color = colors.bg.dark } },
        { Text = LEFT_DIVIDER },
        -- Date section
        { Background = { Color = colors.bg.dark } },
        { Foreground = { Color = colors.fg.dark } },
        { Text = ' ' .. day .. ' ' },
        { Text = ' ' .. date .. ' ' },
        { Foreground = { Color = '#b1b1b1' } },
        { Text = ' ' .. time .. '  ' },
    })

    local prefix = ''
    if window:leader_is_active() then
        prefix = ' ️️🔴🔴🔴 '
    end

    window:set_left_status(wezterm.format {
        { Text = prefix },
    })
end)

-- Create split screen on startup
wezterm.on('gui-startup', function()
    local tab, terminal_pane = mux.spawn_window {
        workspace = 'coding',
        cwd = working_dir,
        size = 0.1,
        args = { os_shell },
    }

    tab:set_title 'Coding'

    local editor_pane = terminal_pane:split {
        direction = 'Right',
        size = 0.9,
        cwd = working_dir,
        top_level = true,
    }

    editor_pane:send_paste 'nvim .'
    if is_windows_platform() then
        terminal_pane:send_paste 'npm run test --'
    end
end)

return config
