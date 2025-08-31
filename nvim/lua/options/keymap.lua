vim.g.mapleader = ' '

-- Enable Telescope
vim.keymap.set('n', '<C-p>', ':Telescope<CR>', { desc = 'Open Telescope' })
vim.keymap.set('n', '<leader>p', ':Telescope fd<CR>', { desc = 'Open Telescope' })

-- Toggle NvimTree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

vim.keymap.set(
    'n',
    '<leader>?',
    function()
        require("which-key").show({ global = false })
    end
)

