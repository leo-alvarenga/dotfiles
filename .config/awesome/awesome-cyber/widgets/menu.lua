local hotkeys_popup = require'awful.hotkeys_popup'
local awful = require'awful'
local beautiful = require'beautiful'
local vars = require'shared.vars'

local menu = { }

innermenu = {
    {
        'hotkeys',
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    },
    {
        'edit config',
        vars.code_editor .. ' ' .. awesome.conffile
    },
    {
        'restart', awesome.restart
    }
}

menu.menu = awful.menu(
    {
        items = {
            {
                'awesome',
                innermenu,
                beautiful.awesome_icon
            },
            {
                'Shut down',
                vars.terminal .. ' ' ..  'poweroff'
            }
        }
    }
)

menu.launcher = awful.widget.launcher(
    {
        image = beautiful.awesome_icon,
        menu = menu.menu
    }
)

return menu
