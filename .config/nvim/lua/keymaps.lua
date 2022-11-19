vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap.set
keymap('n', 'x', '"_x', { desc = 'Delete characters under the cursor without yanking' })
keymap('n', '+', '<C-a>', { desc = 'Increment' })
keymap('n', '-', '<C-x>', { desc = 'Decrement' })
keymap('n', '<C-l>', ':nohlsearch<CR><C-l>', { desc = 'Turn off search highlight' }, { silent = true })
keymap('n', '<C-j>', ':bprevious<CR>', { desc = 'Go to previous buffer' }, { silent = true })
keymap('n', '<C-k>', ':bnext<CR>', { desc = 'Go to next buffer' }, { silent = true })
keymap('n', 'ss', ':split<CR><C-w><C-w>', { desc = 'Split window horizontally' }, { silent = true })
keymap('n', 'sv', ':vsplit<CR><C-w><C-w>', { desc = 'Split window vertically' }, { silent = true })
keymap('n', 'sh', '<C-w><', { desc = 'Resize window' }, { silent = true })
keymap('n', 'sj', '<C-w>+', { desc = 'Resize window' }, { silent = true })
keymap('n', 'sk', '<C-w>-', { desc = 'Resize window' }, { silent = true })
keymap('n', 'sl', '<C-w>>', { desc = 'Resize window' }, { silent = true })
keymap('n', 'j', 'gj', { desc = 'Lines down' })
keymap('n', 'k', 'gk', { desc = 'Lines up' })
