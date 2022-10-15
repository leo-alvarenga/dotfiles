-- wm libs
local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'

-- custom

local function get_statusbar (s)
    s.statbar = awful.wibar(
        {
            screen = s,
            stretch = false,
            position = 'bottom',
            height = 30,
            visible = false,
            bg = beautiful.bg_wibar,
            width = s.geometry.width,
        }
    )

    s.toggle_statbar = function ()
        s.statbar.visible = not s.statbar.visible
    end

    s.statbar:setup {
        layout = wibox.layout.align.horizontal,
    }
end

return get_statusbar