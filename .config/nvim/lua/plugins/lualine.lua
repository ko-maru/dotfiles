require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'iceberg_dark',
    component_separators = '',
    section_separators = '',
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
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  }
} 
