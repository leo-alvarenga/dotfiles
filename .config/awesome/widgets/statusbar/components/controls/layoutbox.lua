local awful = require'awful'
local gears = require'gears'

local margin_utils = require'shared.margin_utils'

local layoutbox = awful.widget.layoutbox(s)
-- Interactions with the mouse
layoutbox:buttons(
    gears.table.join(
        awful.button(
            { }, 1,
            function ()
                awful.layout.inc( 1)
            end
        ),

        awful.button(
            { }, 3, 
            function () 
                awful.layout.inc(-1) 
            end
        ),

        awful.button(
            { }, 4, 
            function () 
                awful.layout.inc( 1) 
            end
        ),

        awful.button(
            { }, 5, 
            function () 
                awful.layout.inc(-1)
            end
        )
    )
)

layoutbox = margin_utils.add_margin(
    layoutbox,
    0, 0, 0, 0
)

return layoutbox