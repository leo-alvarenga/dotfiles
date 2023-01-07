return {
    text       = '#fefefe',
    subtext1   = '#b8c0e0',
    subtext0   = '#a5adcb',
    overlay2   = '#939ab7',
    overlay1   = '#8087a2',
    overlay0   = '#6e738d',
    surface2   = '#5b6078',
    surface1   = '#494d64',
    surface0   = '#363a4f',
    base       = '#24273a',
    mantle     = '#1e2030',
    crust      = '#181926',
    gray	   = '#333333',
    black1     = '#130D18',
    background = '#000000',
    foreground = '#fefefe',
    selection  = '#fefefe',
    comment    = '#fefefe',
    red        = '#FF5555',
    orange     = '#FFB86C',
    yellow     = '#F1FA8C',
    green      = '#50FA7B',
    purple     = '#BD93F9',
    cian       = '#8BE9FD',
    pink       = '#FF79C6',

    add_opacity = function(color, op)
        if type(op) ~= 'number' then return color end

        return color .. op
    end
}
