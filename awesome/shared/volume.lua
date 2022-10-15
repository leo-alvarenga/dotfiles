local awful = require'awful'
local gfs = require'gears.filesystem'

local config_dir = gfs.get_configuration_dir()
local volume = {}

volume.icons = {
    low = config_dir .. 'assets/icons/low-volume.svg',
    mid = config_dir .. 'assets/icons/mid-volume.svg',
    high = config_dir .. 'assets/icons/high-volume.svg',
    muted = config_dir .. 'assets/icons/muted-volume.svg',
}

-- v is the volume level offset, decrease is a boolean flag to determine
-- whether to decrease (true) or not (false)
-- if v is not a number, it will mute (if the level is > 0) or unmute (otherwise)
volume.set_volume = function (v, decrease)
    awful.spawn.easy_async(
        'amixer -c 1 get Master',
        function(stdout, _, _, _)
            local percentage_sign_at = stdout:find('[%%]')

            local value = stdout:sub(percentage_sign_at-3, percentage_sign_at-1)
            value = value:gsub('%s+', '')

             -- checks if the value fetched is less than 10 (1 digit)
            if value:find('[[]') ~= nil then
                value = value:sub(2, value:len())
            end

            local level = tonumber(value)

            if type(v) == 'number' then
                v = tostring(v)

                if decrease then
                    v = v .. '-'
                else
                    v = v .. '+'
                end

                awful.spawn('amixer -c 1 set Master ' .. v)
            else
                if level <= 0 or level == nil then
                    awful.spawn('amixer -c 1 set Master 100')
                else
                    awful.spawn('amixer -c 1 set Master 0')
                end
            end
        end
    )
end

return volume