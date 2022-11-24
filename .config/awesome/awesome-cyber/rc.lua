-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

-- Standard awesome library
local gears = require'gears'
local awful = require'awful'
require'awful.autofocus'

-- Theme handling library
local beautiful = require'beautiful'

-- Notification library
local naughty = require'naughty'
local menubar = require'menubar'

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require'awful.hotkeys_popup.keys'


-- Importing my custom theme {{
local theme_path = 'theme/theme.lua'
beautiful.init(gears.filesystem.get_configuration_dir() .. theme_path)
beautiful.init(beautiful.get())

-- }}}

-- my custom modules {{

require'core.layouts' -- invokes all the layout setting
local global = require'core.keys.global'
local mouse_buttons = require'core.keys.mouse_buttons'

local vars = require'shared.vars'

-- }}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = 'Oops, there were errors during startup!',
            text = awesome.startup_errors 
        }
    )
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal('debug::error',
    function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify(
            {
                preset = naughty.config.presets.critical,
                title = 'Oops, an error happened!',
                text = tostring(err)
            }
        )

        in_error = false
    end)
end
-- }}}


-- Menubar configuration
menubar.utils.terminal = vars.terminal -- Set the terminal for applications that require it

-- {{{ Wibar
-- Create a wibox for each screen and add it

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
require'core.screen'
-- }}}

-- {{{ Mouse bindings
root.buttons(mouse_buttons)
-- }}}

-- Set keys
root.keys(global.keys)

-- Rules to apply to new clients (through the 'manage' signal).
require'core.rules'

-- Signal function to execute when a new client appears.
require'core.signals'

-- Apps on startup
-- awful.util.spawn('xautolock ')
awful.util.spawn('picom --config .config/picom/picom.conf')
awful.util.spawn('flameshot')
awful.util.spawn('xautolock -time 10 -locker "$HOME/.config/i3lock/i3lock.sh"')
