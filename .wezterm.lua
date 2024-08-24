local wezterm = require 'wezterm' -- Pull in the wezterm API
local mux = wezterm.mux

local config = {} -- This table will hold the configuration.

local working_dir = wezterm.home_dir
local color_schemes = { Adventure = 'Adventure', Abernathy = 'Abernathy', Argonaut = 'Argonaut' }

local windows_platform = 'x86_64-pc-windows-msvc'
local function is_windows_platform()
    return wezterm.target_triple == windows_platform
end

local os_shell = 'bash'
if is_windows_platform() then
    os_shell = 'pwsh.exe'
    working_dir = 'C:/Projects/gliderbim.webapp/GliderBim.WebApp'
end

if wezterm.config_builder then
    config = wezterm.config_builder()
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
        key = 'i',
        action = wezterm.action.ActivateTabRelative(1),
    },
    { -- go to previous tab
        mods = 'LEADER',
        key = 'o',
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
    { -- [r]esize panes
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

        if percentage_value > 50 then
            battery = '󰁹 ' .. percentage
        else
            battery = '󰁾' .. percentage
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
            light = bg_color,
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
        workspace = 'code-editor',
        cwd = working_dir,
        size = 0.1,
        args = { os_shell },
    }

    tab:set_title 'Editor'

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
