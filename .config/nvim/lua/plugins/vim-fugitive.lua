opt = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>ga', ":Git add .<CR>", opt)
vim.keymap.set('n', '<leader>gb', ":Git blame<CR>", opt)
vim.keymap.set('n', '<leader>gc', ":Git commit<CR>", opt)
vim.keymap.set('n', '<leader>gdw', ":Git diff<CR>", opt)
vim.keymap.set('n', '<leader>gdi', ":Git diff --cached<CR>", opt)
vim.keymap.set('n', '<leader>gll', ":Git log<CR>", opt)
vim.keymap.set('n', '<leader>glo', ":Git log --oneline<CR>", opt)
vim.keymap.set('n', '<leader>gs', ":Git<CR>", opt)
