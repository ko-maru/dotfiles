return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = {
              query = "@function.outer",
              desc = "function",
            },
            ["if"] = {
              query = "@function.inner",
              desc = "inner function",
            },
            ["ac"] = {
              query = "@class.outer",
              desc = "class",
            },
            ["ic"] = {
              query = "@class.inner",
              desc = "inner class",
            },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = { query = "@function.inner", desc = "Next function" },
            ["]c"] = { query = "@class.inner", desc = "Next class" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@function.inner", desc = "Previous function" },
            ["[c"] = { query = "@class.inner", desc = "Previous class" },
          },
        },
      },
    })
  end,
}
