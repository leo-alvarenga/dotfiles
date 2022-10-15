local wibox = require'wibox'
local awful = require'awful'
local beautiful = require'beautiful'

local color_scheme = require'theme.colors'
local brightness_util = require'shared.brightness'

local brightness_tooltip = awful.tooltip { }
local brightness = wibox.widget {
    {
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
                image  = brightness_util.icon,
                resize = false,
                widget = wibox.widget.imagebox
            },
            widget  = wibox.container.place
        },

        layout = wibox.layout.stack
    },

    left = 5,
    rigth = 5,

    widget = wibox.container.margin
}

brightness_tooltip:add_to_object(brightness)

return awful.widget.watch(
    'brightnessctl',
    1,
    function (widget, stdout, _, _, _)
        local percentage_sign_at = stdout:find('[%%]')

        local value = stdout:sub(percentage_sign_at-3, percentage_sign_at-1)
        value = value:gsub('%s+', '')

        if value:find('[(]') ~= nil then
            value = value:sub(2, value:len())
        end

        local level = tonumber(value)
        widget.children[1].children[1].value = level

        brightness_tooltip.text = 'Brightness: ' .. level .. '%'
    end,
    brightness
)