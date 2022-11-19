local lspsaga = require 'lspsaga'
lspsaga.setup {}

local keymap = vim.keymap.set
local opts = { silent = true, noremap = true }

keymap('n', '<leader>a', '<Cmd>Lspsaga code_action<CR>', opts)
keymap('v', '<leader>a', ':<C-u>Lspsaga range_code_action<CR>', opts)
keymap('n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
keymap('n', ']d', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
keymap('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', opts)
keymap('n', '<leader>rn', '<Cmd>Lspsaga rename<CR>', opts)
keymap('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)


