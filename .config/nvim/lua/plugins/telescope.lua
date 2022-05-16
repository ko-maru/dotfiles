local telescope = require 'telescope'
local trouble = require 'trouble.providers.telescope'

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

vim.keymap.set('n', '<leader>fs', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>ft', require('telescope.builtin').tags)
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>fp', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>fo', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>f?', require('telescope.builtin').oldfiles)
vim.keymap.set('n', '<leader>fgc', require('telescope.builtin').git_commits)
vim.keymap.set('n', '<leader>fgb', require('telescope.builtin').git_branches)
vim.keymap.set('n', '<leader>fgs', require('telescope.builtin').git_status)

vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
