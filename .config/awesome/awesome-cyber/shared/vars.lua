local vars = {
    terminal = 'alacritty',
    editor = os.getenv('EDITOR') or 'vim'
}

vars.modkey = 'Mod4'
vars.editor_cmd = vars.terminal .. ' -e ' .. vars.editor
vars.code_editor = vars.terminal .. 'code'

return vars
