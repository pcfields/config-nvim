local wezterm = require 'wezterm' -- Pull in the wezterm API
local mux = wezterm.mux

local config = {} -- This table will hold the configuration.

local windows_platform = 'x86_64-pc-windows-msvc'
local work_webapp_dir = 'C:\\Projects\\gliderbim.webapp\\GliderBim.WebApp'
local linux_home_dir = '~/ws'
local working_dir
local os_shell
local function is_windows_platform()
    return wezterm.target_triple == windows_platform
end

local color_schemes = { Adventure = 'Adventure', Abernathy = 'Abernathy', Argonaut = 'Argonaut' }

if is_windows_platform() then
    working_dir = work_webapp_dir
    os_shell = 'pwsh.exe'
else
    working_dir = linux_home_dir
    os_shell = 'bash'
end

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
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
-- config.use_fancy_tab_bar = false
config.font = wezterm.font {
    family = 'JetBrains Mono',
    weight = 'Medium',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}

config.leader = { key = 'Space', mods = 'SHIFT', timeout_milliseconds = 2000 }
-- https://www.florianbellmann.com/blog/switch-from-tmux-to-wezterm
config.keys = {
    { -- split bottom
        mods = 'LEADER',
        key = 'b',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    { -- split right
        mods = 'LEADER',
        key = 'r',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    { -- Maximize pane
        mods = 'LEADER',
        key = 'm',
        action = wezterm.action.TogglePaneZoomState,
    },
    { -- rotate panes
        mods = 'LEADER',
        key = 's',
        action = wezterm.action.RotatePanes 'Clockwise',
    },
    { -- show the pane selection mode SWAP,
        mods = 'LEADER',
        key = '0',
        action = wezterm.action.PaneSelect { mode = 'Activate' },
    },
    { -- activate copy mode or vim mode
        mods = 'LEADER',
        key = 'Enter',
        action = wezterm.action.ActivateCopyMode,
    },
    { -- create new tab
        mods = 'LEADER',
        key = 'c',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    { -- delete tab
        mods = 'LEADER',
        key = 'x',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    { -- go the next tab
        mods = 'LEADER',
        key = 'n',
        action = wezterm.action.ActivateTabRelative(1),
    },
    { -- go to previous tab
        mods = 'LEADER',
        key = 'p',
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
    { -- increase width to the left
        mods = 'LEADER',
        key = 'i',
        action = wezterm.action.AdjustPaneSize { 'Left', 20 },
    },
    { -- increase width to the right
        mods = 'LEADER',
        key = 'o',
        action = wezterm.action.AdjustPaneSize { 'Right', 20 },
    },
    { -- move pane height down
        mods = 'LEADER',
        key = 'DownArrow',
        action = wezterm.action.AdjustPaneSize { 'Down', 20 },
    },
    { -- move pane height up
        mods = 'LEADER',
        key = 'UpArrow',
        action = wezterm.action.AdjustPaneSize { 'Up', 20 },
    },
    { -- go to first tab
        mods = 'LEADER',
        key = '1',
        action = wezterm.action.ActivateTab(0),
    },
    { -- go to second tab
        mods = 'LEADER',
        key = '2',
        action = wezterm.action.ActivateTab(1),
    },
    { -- go to third tab
        mods = 'LEADER',
        key = '3',
        action = wezterm.action.ActivateTab(2),
    },
    { -- go to 4th tab
        mods = 'LEADER',
        key = '4',
        action = wezterm.action.ActivateTab(3),
    },
    { -- go to 5th tab
        mods = 'LEADER',
        key = '5',
        action = wezterm.action.ActivateTab(4),
    },
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
wezterm.on('update-right-status', function(window, pane)
    local date = wezterm.strftime '%b %-d' -- "Wed Mar 3 08:14"
    local day = wezterm.strftime '%a' -- "Wed Mar 3 08:14"
    local time = wezterm.strftime '%H:%M' -- "Wed Mar 3 08:14"
    local battery = ''

    for _, b in ipairs(wezterm.battery_info()) do
        battery = '   🔋' .. string.format('%.0f%%', b.state_of_charge * 100)
    end

    window:set_right_status(wezterm.format {
        { Background = { Color = '#222' } },
        { Text = battery .. ' ' },
        { Foreground = { Color = '#999' } },
        { Text = '' },
        { Text = ' ' .. day .. ' ' },
        { Foreground = { Color = 'white' } },
        { Text = ' ' .. date .. ' ' },
        { Foreground = { Color = 'green' } },
        { Text = ' ' .. time .. ' ' },
        { Foreground = { Color = '#999' } },
        { Text = '' },
        { Text = '~ ' .. wezterm.home_dir .. ' ' },
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
    -- allow `wezterm start -- something` to affect what we spawn
    -- in our initial Windows

    local tab, terminal_pane = mux.spawn_window {
        workspace = 'code-editor',
        cwd = working_dir,
        args = { os_shell },
        size = 0.1,
    }

    tab:set_title 'Editor'

    local editor_pane = terminal_pane:split {
        direction = 'Right',
        size = 0.9,
        cwd = working_dir,
        top_level = true,
    }

    editor_pane:send_paste 'nvim .'
    terminal_pane:send_paste 'npm run test --'
end)

return config
