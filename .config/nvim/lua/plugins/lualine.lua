return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      section_separators = "",
      component_separators = "",
      global_status = true,
      theme = "gruvbox-material",
    },
    sections = {
      lualine_x = {
        "encoding",
        {
          "fileformat",
          icons_enabled = false,
        },
        "filetype",
      },
    },
  },
}
