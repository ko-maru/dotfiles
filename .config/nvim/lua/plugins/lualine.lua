local lualine = require('lualine')

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'OceanicNext',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_lsp' }
      }
    },
    lualine_c = { 'filename' },
    lualine_x = { 
      'encoding', 
      {
        'fileformat',
        icons_enabled = false
      },
      'filetype' 
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        mode = 0,
        max_length = vim.o.columns
      }
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {}, 
    lualine_z = {},
  }
}
