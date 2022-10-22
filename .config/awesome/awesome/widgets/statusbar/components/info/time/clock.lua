local wibox = require'wibox'
local gears = require'gears'
local awful = require'awful'
local beautiful = require'beautiful'

local margin_utils = require'shared.margin_utils'
local popup = require'widgets.statusbar.components.info.time.popup'

local clock_tooltip = awful.tooltip{
    text = 'Open calendar'
}

local clock = margin_utils.add_margin(
    wibox.widget.textclock(),
    0, 5, 0, 0
)

clock_tooltip:add_to_object(clock)

clock:buttons(
    gears.table.join(
        awful.button(
            {}, 1,
            function ()
                if popup.visible then
                    clock.children[1].fg = beautiful.bg_wibar
                    popup.visible = not popup.visible

                    clock_tooltip.text = 'Open calendar'
                else
                    clock.children[1].fg = beautiful.wibar_focus
                    popup:move_next_to(mouse.current_widget_geometry)
                    popup.on_open()

                    clock_tooltip.visible = false
                    clock_tooltip.text = 'Close calendar'
                end
            end
        )
    )
)
return clock