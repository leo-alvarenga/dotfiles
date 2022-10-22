local wibox = require'wibox'
local beautiful = require'beautiful'
local awful = require'awful'

local color_scheme = require'theme.colors'
local volume_util = require'shared.volume'

local volume_tooltip = awful.tooltip{ }

local volume_chart = wibox.widget{
    {
        max_value        = 100,
        min_value        = 0,
        value            = 10,
        thickness        = beautiful.arcchar_thickness,
        start_angle      = beautiful.arcchar_start_angle,
        colors = {
            color_scheme.secondary,
        },
        widget           = wibox.container.arcchart,
    },
    {
        {
            image  = volume_util.icons.muted,
            resize = false,
            widget = wibox.widget.imagebox
        },
        widget  = wibox.container.place
    },

    layout = wibox.layout.stack
}

volume_tooltip:add_to_object(volume_chart)

return awful.widget.watch(
    'amixer -c 1 get Master',
    1,
    function (widget, stdout, _, _, _)
        local percentage_sign_at = stdout:find('[%%]')
        local value = stdout:sub(percentage_sign_at-3, percentage_sign_at-1)
        value = value:gsub('%s+', '')
         -- checks if the value fetched is less than 10 (1 digit)
        if value:find('[[]') ~= nil then
            value = value:sub(2, value:len())
        end

        local v = tonumber(value)
        local volume_indicator = volume_util.icons.muted

        if v > 80 then
            volume_indicator = volume_util.icons.high
        elseif v > 40 then
            volume_indicator = volume_util.icons.mid
        elseif v > 0 then
            volume_indicator = volume_util.icons.low
        end

        widget
            .children[2]
            .children[1].image = volume_indicator

        widget.children[1].value = v
        volume_tooltip.text = 'Volume: ' .. value .. '%'
    end,
    volume_chart
)