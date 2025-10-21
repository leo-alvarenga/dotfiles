-- Remappings


-- Ensuring selection is kept after indentation

vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')


--  Motions inspired by Helix :D

vim.keymap.set('n', 'gh', '0')
vim.keymap.set('n', 'gl', '$')
vim.keymap.set('n', 'ge', 'G')

vim.keymap.set('x', 'gh', '0')
vim.keymap.set('x', 'gl', '$')
vim.keymap.set('x', 'ge', 'G')


