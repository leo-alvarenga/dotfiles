local gears = require'gears'
local awful = require'awful'

local vars = require'shared.vars'

local client = { }

client.keys = gears.table.join(
    awful.key(
        { vars.modkey, }, 'f',
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {
            description = 'toggle fullscreen',
            group = 'client'
        }
    ),

    awful.key(
        { vars.modkey, }, 'c',
        function (c)
            c:kill()
        end,
        {
            description = 'close',
            group = 'client'
        }
    ),

    awful.key(
        { vars.modkey, 'Control' }, 'space',
        awful.client.floating.toggle,
        {
            description = 'toggle floating',
            group = 'client'
        }
    ),

    awful.key(
        { vars.modkey, 'Control' }, 'Return',
        function (c)
            c:swap(awful.client.getmaster())
        end,
        {
            description = 'move to master',
            group = 'client'
        }
    ),

    awful.key(
        { vars.modkey, }, 'o',
        function (c)
            c:move_to_screen()
        end,
        {
            description = 'move to screen',
            group = 'client'
        }
    ),

    awful.key(
        { vars.modkey, }, 't',
        function (c)
            c.ontop = not c.ontop
        end,
        {
            description = 'toggle keep on top',
            group = 'client'
        }
    ),

    awful.key(
        { vars.modkey, }, 'n',
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {
            description = 'minimize',
            group = 'client'
        }
    ),

    awful.key(
        { vars.modkey, }, 'm',
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {
            description = '(un)maximize',
            group = 'client'
        }
    ),

    awful.key({ vars.modkey, 'Control' }, 'm',
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {
            description = '(un)maximize vertically',
            group = 'client'
        }
    ),

    awful.key(
        { vars.modkey, 'Shift' }, 'm',
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {
            description = '(un)maximize horizontally',
            group = 'client'
        }
    )
)

client.buttons = gears.table.join(
    -- Raise client when clicked on
    awful.button(
        { }, 1,
        function (c)
            c:emit_signal('request::activate', 'mouse_click', {raise = true})
        end
    ),

    -- Move client freely when the current tag's layout is 'floating'
    awful.button(
        { vars.modkey, 'Shift' }, 1,
        function (c)
            c:emit_signal('request::activate', 'mouse_click', {raise = true})
            awful.mouse.client.move(c)
        end
    ),

    -- Mouse keys
    awful.button(
        { }, 1,
        function (c)
            c:emit_signal(
                'request::activate',
                'mouse_click',
                {
                    raise = true
                }
            )
        end
    ),

    awful.button(
        { vars.modkey }, 1,
        function (c)
            c:emit_signal(
                'request::activate',
                'mouse_click',
                {
                    raise = true
                }
            )

            awful.mouse.client.move(c)
        end
    ),

    awful.button(
        { vars.modkey, 'Control' }, 1,
        function (c)
            c:emit_signal(
                'request::activate',
                'mouse_click',
                {
                    raise = true
                }
            )

            awful.mouse.client.resize(c)
        end
    )
)

return client