return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      section_separators = '',
      component_separators = '',
      global_status = true,
    },
    sections = {
      lualine_x = {
        "encoding",
        {
          "fileformat",
          icons_enabled = false,
          -- symbols = {
          --   unix = "LF",
          --   dos = "CRLF",
          --   mac = "CR,
          -- },
        },
        "filetype",
      },
    },
  },
}
