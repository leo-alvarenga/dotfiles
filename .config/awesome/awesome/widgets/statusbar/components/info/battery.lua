local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'

local color_scheme = require'theme.colors'

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local battery_tooltip = awful.tooltip { }
local battery_bar = wibox.widget {
    {
        max_value        = 100,
        value            = 100,
        colors           = {
            color_scheme.battery_color
        },
        thickness        = beautiful.arcchar_thickness,
        start_angle      = beautiful.arcchar_start_angle,
        background_color = color_scheme.battery_background,
        widget           = wibox.container.arcchart,
    },
    {
        {
            text   = '100%',
            widget = wibox.widget.textbox,
        },

        widget = wibox.container.place,
    },

    layout = wibox.layout.stack,
    widget = wibox.container.place
}
battery_tooltip:add_to_object(battery_bar)

-- battery widget structure, for reference:
-- battery_bar (layout horizontal)
--    |---- .children[1] (progressbar)
--    |
--    |---- .children[2] (margin)
--             |---- .children[1] textbox

-- every 15 seconds, run 'acpi -i' and fetch the battery level from the output
return awful.widget.watch (
    'acpi -i',
    15,
    function(widget, stdout, _, _, _)
        battery_tooltip.text = stdout:sub(0, stdout:find('\n'))
        local percentage_sign_at = stdout:find('[%%]')

        -- trim the stdout to get only the battery level
        local value = stdout:sub(percentage_sign_at-3, percentage_sign_at-1)
        value = value:gsub('%s+', '') -- remove whitespaces

        -- checks if the value fetched is less than 10 (1 digit)
        if value:find(',') ~= nil then
            value = stdout:sub(percentage_sign_at-2, percentage_sign_at-1)
            value = value:gsub('%s+', '')

            -- if it is, the trimmed substr will contain ',', which is used by acpi to
            -- separate the info on its output
        end

        local charge = tonumber(value)

        -- setting progressbar color
        if charge < 15 then
            -- layout -> progressbar
            widget
                .children[1]
                .colors = { color_scheme.battery_color_low }

            -- TODO: spawn a notification for low battery
        else
            -- layout -> progressbar
            widget
                .children[1]
                .colors = { color_scheme.battery_color }
        end

        -- layout -> progressbar
        widget
            .children[1]
            .value = charge

        -- a little thing if the battery is charging
        if stdout:find('Charging') then
            widget
                .children[1]
                .colors = { color_scheme.accent }
        end

        -- layout -> margin -> textbox
        widget
            .children[2]
            .children[1]
            :set_text(value)
    end,
    battery_bar
)