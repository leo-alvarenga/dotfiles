local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

local audio = require("components.audio")
local backlight = require("components.backlight")
local battery = require("components.battery")

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 " }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)

    s.mylayoutbox.forced_height = 16
    s.mylayoutbox.forced_width = 16
    s.mylayoutbox:buttons(
        gears.table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )
    )
    
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = require("core/buttons/taglist")
    }

    local taglist_wrapper = {
        widget = wibox.container.background,
        bg     = beautiful.wibar_bg_wrappers,
        s.mytaglist,
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = require("core/buttons/tasklist")
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            widget = wibox.container.margin,
            top    = 10,
            bottom = 10,
            left   = 10,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                taglist_wrapper,
                {
                    widget = wibox.container.background,
                    bg     = beautiful.wibar_bg_wrappers,
                    {
                        widget = wibox.container.margin,
                        draw_empty = false,
                        right  = 10,
                        left = 10,
                        s.mypromptbox
                    }
                },
            }
        },
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal
        }, -- Middle widget

        {
            widget = wibox.container.margin,
            top    = 10,
            bottom = 10,
            right  = 10,
            {
                widget = wibox.container.background,
                bg     = beautiful.wibar_bg_wrappers,
                { -- Right widgets
                    layout = wibox.layout.fixed.horizontal,
                    {
                        widget = wibox.container.margin,
                        left   = 2,
                        right  = 12,
                        wibox.widget.systray(),
                    },
                    {
                        widget = wibox.container.margin,
                        right  = 20,
                        backlight,
                    },
                    {
                        widget = wibox.container.margin,
                        right  = 20,
                        audio,
                    },
                    {
                        widget = wibox.container.margin,
                        right  = 8,
                        battery,
                    },
                    mytextclock,
                    {
                        widget = wibox.container.margin,
                        top    = 2,
                        left   = 8,
                        right  = 8,
                        s.mylayoutbox,
                    },

                    {
                        -- whenever this is removed the layout box clips out of the bar
                        layout = wibox.layout.fixed.horizontal
                    }
                },
            }
        }
    }
end)
-- }}}
