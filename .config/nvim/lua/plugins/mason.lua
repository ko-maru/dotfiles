return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "csharp_ls",
        "cssls",
        "emmet_ls",
        "html",
        "jsonls",
        "lua_ls",
        "prismals",
        "rust_analyzer",
        "tsserver",
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettierd",
        "stylua",
        "eslint_d",
      },
    })
  end,
}
