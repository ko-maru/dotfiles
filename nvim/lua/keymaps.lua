vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true })

vim.keymap.set("n", "<C-j>", ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", ':bprev<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

