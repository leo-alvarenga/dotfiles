local awful = require'awful'
local gears = require'gears'
local wibox = require'wibox'
local naughty = require'naughty'
local beautiful = require'beautiful'

local function decorate_cell(widget, flag, date)
end

local calendar = wibox.widget{
    date = os.date('*t'),
    long_weekdays = true,
    widget = wibox.widget.calendar.month
}

calendar:buttons(
    gears.table.join(
        awful.button(
            {}, 1,
            function ()
                local date = calendar.date

                if date.month == 12 then
                    date.month = 1
                    date.year = date.year + 1
                else
                    date.month = date.month + 1
                end

                calendar.date = date

                calendar.widget = wibox.widget.calendar.month
            end
        )
    )
)

local calendar_popup = awful.popup {
    widget = {
        {
            calendar,
            layout = wibox.layout.fixed.vertical,
        },
        margins = 10,
        widget  = wibox.container.margin
    },

    border_width = 1,
    border_color = beautiful.bg_focus,
    bg = beautiful.popup_bg,

    offset = {
        y = 10
    },

    ontop        = true,
    fn_embed     = decorate_cell,
    shape        = gears.shape.rounded_rect,
    visible      = false,
}

calendar_popup.on_open = function ()
    calendar_popup
        .widget
        .children[1]
        .children[1].date = os.date('*t')
end

return calendar_popup