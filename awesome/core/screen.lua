local gears = require'gears'
local awful = require'awful'
local beautiful = require'beautiful'

local statusbar = require'widgets.statusbar.statusbar'

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper

        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == 'function' then
            wallpaper = wallpaper(s)
        end

        -- the last arg must be false; wallpaper might be stretched otherwise
        gears.wallpaper.maximized(wallpaper, s, false)
    end
end

-- Resize wallpaper if the screen resolution changes
screen.connect_signal('property::geometry', set_wallpaper)

-- Add status bar to each screen
awful.screen.connect_for_each_screen(
    function (s)
        set_wallpaper(s)
        statusbar(s)
    end
)