-- awesome imports
local awful = require('awful')

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile, -- side by side
    awful.layout.suit.floating, -- freely move the clients
    awful.layout.suit.tile.top, -- sid by side (horizontaly)
    awful.layout.suit.max,  -- maximized clients
}
