local awful = require'awful'
local gears = require'gears'
local wibox = require'wibox'
local beautiful = require'beautiful'

local vars = require'shared.vars'
local global = require'core.keys.global'

local tag_meta = require'shared.tags'

local tags = {
}

tags.buttons = gears.table.join(
    awful.button(
        { }, 1,
        function(t)
            t:view_only()
        end
    ),

    awful.button(
        { vars.modkey }, 1,
        function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end
    ),

    awful.button(
        { }, 3,
        awful.tag.viewtoggle
    ),

    awful.button(
        { vars.modkey }, 3,
        function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end
    ),

    awful.button(
        { }, 4,
        function(t)
            awful.tag.viewnext(t.screen)
        end
    ),

    awful.button(
        { }, 5,
        function(t)
            awful.tag.viewprev(t.screen)
        end
    )
)

for i = 1, tag_meta.tag_count do
    global.keys = gears.table.join(global.keys,
        -- View tag only.
        awful.key(
            { vars.modkey }, '#' .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]

                if tag then
                    tag:view_only()
                end
            end,
            {
                description = 'view tag '..i,
                group = 'tag'
            }
        ),

        -- Toggle tag display.
        awful.key(
            { vars.modkey, 'Control' }, '#' .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]

                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {
                description = 'toggle tag '..i,
                group = 'tag'
            }
        ),

        -- Move client to tag.
        awful.key(
            { vars.modkey, 'Shift' }, '#' .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]

                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {
                description = 'move focused client to tag '..i,
                group = 'tag'
            }
        ),

                -- Toggle tag on focused client.
        awful.key(
            { vars.modkey, 'Control', 'Shift' }, '#' .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]

                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {
                description = 'toggle focused client on tag '..i,
                group = 'tag'
            }
        )
    )
end

tags.get_widget = function (s)
    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = tags.buttons,
        widget_template = {
            {
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox
                },

                id     = 'bg',
                widget = wibox.container.background,
                create_callback = function(self, t, _, _)
                    self.bg = beautiful.bg_wibar
                end,
            },

            left = 10,
            right = 5,
            id = 'text_margin_role',
            widget = wibox.container.margin
        }
    }
end

return tags