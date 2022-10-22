local awful = require'awful'

local tags = {
    markers = {'○', '○', '○', '○', '○', '○'},
    default = '○',
    active = '●',
    tag_count = 6,
}

tags.set_tag_names = function ()
    local screen = awful.screen.focused()

    for t = 1, tags.tag_count do
        if screen.tags[t] then
            screen.tags[t].name = tags.default
        end
    end

    local tag = screen.selected_tag
    tag.name = tags.active
end

return tags