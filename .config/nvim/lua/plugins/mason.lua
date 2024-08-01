return {
  "williamboman/mason.nvim",
  dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate" },
  config = function()
    require("mason").setup()

    local ensure_installed = {
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
    }

    if vim.fn.executable("dotnet") then
      local version = vim.fn.system({ "dotnet", "--version" })
      if string.match(version, "^8") then
        table.insert(ensure_installed, "csharp_ls")
      end
    end

    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
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
