-- wm libs
local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'

-- custom
local tags = require'widgets.statusbar.components.lists.tags'
local tasklist = require'widgets.statusbar.components.lists.tasklist'

local systray = require'widgets.statusbar.components.info.systray'
local battery = require'widgets.statusbar.components.info.battery'
local clock = require'widgets.statusbar.components.info.time.clock'

local layoutbox = require'widgets.statusbar.components.controls.layoutbox'
local volume = require'widgets.statusbar.components.controls.volume'
local brightness = require'widgets.statusbar.components.controls.brightness'

local tag_meta = require'shared.tags'
local margin_utils = require'shared.margin_utils'

local wibar_margin = 10

local function get_statusbar (s)
    awful.tag(tag_meta.markers, s, awful.layout.layouts[1])

    s.mypromptbox = awful.widget.prompt() -- only need if prompt is binded somewhere

    s.mylayoutbox = layoutbox

    -- Create a taglist widget
    s.mytaglist = tags.get_widget(s)

    s:connect_signal(
        'tag::history::update',
        function()
            tag_meta.set_tag_names()
        end
    )

    s.mytasklist = tasklist(s)
    s.mywibox = awful.wibar(
        {
            screen = s,
            stretch = false,
            position = 'top',
            height = 30,
            bg = beautiful.bg_wibar,
            width = s.geometry.width,
        }
    )

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,

        {
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },

        margin_utils.add_margin(
            s.mytasklist,
            wibar_margin, wibar_margin
        ),

        {
            layout = wibox.layout.fixed.horizontal,

            margin_utils.add_margin(
                systray.widget,
                5, 5
            ),

            margin_utils.add_margin(
                systray.handler,
                5
            ),

            margin_utils.add_margin(
                brightness,
                15
            ),

            margin_utils.add_margin(
                volume,
                15
            ),

            margin_utils.add_margin(
                battery,
                15
            ),

            margin_utils.add_margin(
                clock,
                10, 5
            ),

            s.mylayoutbox
        },
    }
end

return get_statusbar