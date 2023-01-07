local wibox = require'wibox'
local beautiful = require'beautiful'
local awful = require'awful'

local audio_util = require'actions.audio'

local audio = wibox.widget{
    {
        widget = wibox.container.margin,
        top    = 5,
        right  = 6,
        {
            image  = audio_util.icons.muted,
            resize = false,
            widget = wibox.widget.imagebox
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
        local volume_indicator = audio_util.icons.muted
        widget.children[2].markup = '<i>0%</i>'
        widget.children[2].opacity = 0.6

        if v > 80 then
            volume_indicator = audio_util.icons.high
            widget.children[2].markup = value .. '%'
            widget.children[2].opacity = 1
        elseif v > 40 then
            volume_indicator = audio_util.icons.mid
            widget.children[2].markup = value .. '%'
            widget.children[2].opacity = 1
        elseif v > 0 then
            volume_indicator = audio_util.icons.low
            widget.children[2].markup = value .. '%'
            widget.children[2].opacity = 1
        end

        widget
            .children[1]
            .children[1].image = volume_indicator
    end,
    audio
)