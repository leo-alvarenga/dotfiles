return {
    background = '#140713', 
    active     = '#452493', 
    disabled   = '#1C0B21',
    urgent     = '#44203C', 
    occupied   = '#1C0C3B',
    foreground = '#F8F8F2',
    selection  = '#44475A',
    comment    = '#6272A4',
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
