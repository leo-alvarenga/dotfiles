local wibox = require'wibox'

local margin_utils = { 
    add_margin = function (widget, left, right, top, bottom)
        return wibox.container.margin(
            widget,
            left, right, top, bottom
        )
    end
}

return margin_utils