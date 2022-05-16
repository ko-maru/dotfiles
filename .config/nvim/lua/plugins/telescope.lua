local telescope = require('telescope')
local trouble = require('trouble.providers.telescope')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-t>'] = trouble.open_with_trouble,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
      n = {
        ['<C-t>'] = trouble.open_with_trouble
      }
    },
  },
}

telescope.load_extension 'fzf'

local builtin = require('telescope.builtin')
-- file picker
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
-- vim picker
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
-- git picker
vim.keymap.set('n', '<leader>fgc', builtin.git_commits)
vim.keymap.set('n', '<leader>fgbr', builtin.git_commits)
vim.keymap.set('n', '<leader>fgbc', builtin.git_branches)
vim.keymap.set('n', '<leader>fgs', builtin.git_status)
-- lsp picker
vim.keymap.set('n', '<leader>fr', builtin.lsp_references)
