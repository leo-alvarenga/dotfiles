local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'

local gfs = require'gears.filesystem'

local colors = require'components.colors'

local config_dir = gfs.get_configuration_dir()
local icons = {
    low = config_dir .. 'assets/icons/low-volume.svg',
    discharging = config_dir .. 'assets/icons/mid-volume.svg',
    charging = config_dir .. 'assets/icons/high-volume.svg',
}

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local battery_tooltip = awful.tooltip { }
local battery_bar = wibox.widget {
    {
        widget = wibox.container.margin,
        top    = 3,
        bottom = 3,
        right  = 6,
        {
            {
                color = colors.foreground,
                background_color = colors.comment,
                max_value     = 100,
                value         = 0,
                widget        = wibox.widget.progressbar,
            },
            forced_height = 20,
            forced_width  = 8,
            direction     = "east",
            layout        = wibox.container.rotate,
        }
    },
    {
        markup = "<b>?</b>%",
        halign = "center",
        valign = "center",
        widget = wibox.widget.textbox
    },    
    layout = wibox.layout.fixed.horizontal
}

battery_tooltip:add_to_object(battery_bar)

-- every 15 seconds, run 'acpi -i' and fetch the battery level from the output
return awful.widget.watch (
    'acpi -i',
    15,
    function(widget, stdout, _, _, _)
        
        -- split the output on '\n'
        local info = stdout:gmatch("([^\n]*)\n")
        local desired_bat = 1 -- which battery should be used

        local out = ''
        local count = 1
        for line in info do
            if count >= desired_bat then
                out = line
                break
            end

            count = count + 1
        end

        battery_tooltip.text = out
        local percentage_sign_at = out:find('[%%]')

        -- trim the out to get only the battery level
        local value = out:sub(percentage_sign_at-4, percentage_sign_at-1)
        value = value:gsub('%s+', '') -- remove whitespaces

        -- checks if the value fetched is less than 10 (1 digit)
        if value:find(',') ~= nil then
            value = out:sub(percentage_sign_at-2, percentage_sign_at-1)
            value = value:gsub('%s+', '')

            -- if it is, the trimmed substr will contain ',', which is used by acpi to
            -- separate the info on its output
        end

        local charge = tonumber(value)

        widget
            .children[1]
            .children[1]
            .children[1].value = charge

        -- setting progressbar color
        if charge < 15 then
            widget
                .children[1]
                .children[1]
                .children[1].color = colors.red
            
            widget
                .children[2]
                .markup = '<i>' .. value .. '%!</i>'

            -- TODO: spawn a notification for low battery
        else
            widget
                .children[2]
                .markup = value .. '%-'
        end

        -- a little thing if the battery is charging
        if out:find('Charging') then
            widget
                .children[1]
                .children[1]
                .children[1].color = colors.green

            widget
                .children[2]
                .markup = '<b>' .. value .. '%+</b>'
        end
    end,
    battery_bar
)
