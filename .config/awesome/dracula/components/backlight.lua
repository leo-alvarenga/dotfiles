local wibox = require'wibox'
local beautiful = require'beautiful'
local awful = require'awful'

local brightness = require'actions.brightness'

local backlight = wibox.widget{
    {
        widget = wibox.container.margin,
        top    = 2,
        right  = 6,
        {
            image  = brightness.icon,
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
    'brightnessctl',
    1,
    function (widget, stdout, _, _, _)
        local percentage_sign_at = stdout:find('[%%]')

        local value = stdout:sub(percentage_sign_at-3, percentage_sign_at-1)
        value = value:gsub('%s+', '')

        if value:find('[(]') ~= nil then
            value = value:sub(2, value:len())
        end

        widget.children[2].markup = value .. '%'
    end,
    backlight
)
