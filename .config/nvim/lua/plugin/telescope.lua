local keymap = vim.keymap.set
local builtin = require 'telescope.builtin'

keymap('n', '<leader>ff', builtin.find_files, {desc = 'Lists file in your current directory'})
keymap('n', '<leader>fr', builtin.live_grep, {desc = 'Search for a text in your current directory'})
keymap('n', '<leader>fb', builtin.buffers, {desc = 'Lists open buffers'})
keymap('n', '<leader>fh', builtin.help_tags, {desc = 'Lists available help tags'})
keymap('n', '<leader>fr', builtin.lsp_references, {desc = 'Lists LSP references for word under the cursor'})
keymap('n', '<leader>fgc', builtin.git_commits, {desc = 'Lists git commits'})
keymap('n', '<leader>fgb', builtin.git_branches, {desc = 'Lists git branches'})
keymap('n', '<C-e>', ':Telescope file_browser<CR>', {desc = 'File browser'})

local telescope = require 'telescope'
telescope.setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension "file_browser"
