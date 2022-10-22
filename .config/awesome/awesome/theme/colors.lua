-- set the color_scheme table values depending on the theme_name
-- defaults to 'cyberpunk'
local function add_transparency(color, transparency)
    return color .. transparency
end

local color_scheme = { }

local function set_color_scheme(theme_name)
    local themes = {
        ['cyberpunk'] = {
            primary       = '#0b0f18',
            secondary     = '#d600ff',
            urgent        = '#00b8ff',
            accent        = '#00ff9f',
            text          = '#efd6ac',
            primary_focus = add_transparency('#0b0f18', 30),

            -- battery colors
            battery_background = '#0b0f18',
            battery_color      = '#d600ff',
            battery_color_low  = '#00b8ff',
        }
    }

    color_scheme = themes[theme_name]

    if color_scheme == nil then
        color_scheme = themes['cyberpunk']
    end

end

set_color_scheme('cyberpunk')
color_scheme.add_transparency = add_transparency

return color_scheme