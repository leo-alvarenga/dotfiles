local wibox = require'wibox'
local awful = require'awful'
local gears = require'gears'

local systray = { }

systray.tooltip = awful.tooltip{
    text = 'Show systray'
}

systray.widget = wibox.widget.systray()
systray.widget.visible = false

systray.toogle = function ()
    systray.widget.visible = not systray.widget.visible
end

systray.handler = wibox.widget{
    {    {
            text = '▼',
            widget = wibox.widget.textbox
        },

        open = false,
        widget = wibox.container.rotate
    },

    widget = wibox.container.place
}

systray.tooltip:add_to_object(systray.handler)

systray.handler:buttons(
    gears.table.join(
        awful.button(
            {}, 1,
            function ()
                if systray.handler.open then
                    systray.handler.children[1].children[1].text = '▼'
                    systray.tooltip.text = 'Show systray and statbar'

                    systray.handler.children[1].direction = 'north'
                else
                    systray.handler.children[1].children[1].text = '▽'
                    systray.tooltip.text = 'Hide systray and statbar'

                    systray.handler.children[1].direction = 'west'
                end

                systray.handler.open = not systray.handler.open
                systray.toogle()
            end
        )
    )
)

return systray