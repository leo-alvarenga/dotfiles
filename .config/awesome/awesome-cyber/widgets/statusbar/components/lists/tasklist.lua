local gears = require'gears'
local awful = require'awful'
local wibox = require'wibox'

local tasklist = gears.table.join(
    awful.button(
        { }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal(
                    'request::activate',
                    'tasklist',
                    {raise = true}
                )
            end
        end
    ),
    
    awful.button(
        { }, 3,
        function()
            awful.menu.client_list(
                {
                    theme = { width = 400 }
                }
            )
        end
    ),
    
    awful.button(
        { }, 4,
        function ()
            awful.client.focus.byidx(1)
        end
    ),
    
    awful.button(
        { }, 5, 
        function ()
            awful.client.focus.byidx(-1)
        end
    )
)

local function get_widget(s)
    return awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist,
        layout   = {
            spacing_widget = {
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 1,
            layout  = wibox.layout.fixed.horizontal
        },
    }
end

return get_widget