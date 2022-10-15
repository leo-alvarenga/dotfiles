local awful = require'awful'
local gfs = require'gears.filesystem'

local brightness = { }

-- Icons to be used on the brightness widget inner textbox
brightness.icon = gfs.get_configuration_dir() .. 'assets/icons/brightness.svg'

-- step is the value offset, decrease is a boolean flag to determine
-- whether to decrease (true) or not (false)
brightness.set_brightness = function (step, decrease)
    awful.spawn.easy_async(
        'brightnessctl',
        function (stdout, _, _, _)
            local percentage_sign_at = stdout:find('[%%]')

            local value = stdout:sub(percentage_sign_at-3, percentage_sign_at-1)
            value = value:gsub('%s+', '')

            if value:find('[(]') ~= nil then
                value = value:sub(2, value:len())
            end

            local level = tonumber(value)

            local cmd = ''

            if decrease then
                if (level - step) >= 10 then
                    cmd = 'brightnessctl set ' .. level - step .. '%'
                end
            else
                if (level + step) <= 100 then
                    cmd = 'brightnessctl set ' .. level + step .. '%'
                end
            end

            awful.spawn(cmd)
        end
    )
end

return brightness