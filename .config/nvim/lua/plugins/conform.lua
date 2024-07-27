return {
  'stevearc/conform.nvim',
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
        typescript = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
        json = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
        jsonc = { "biome-check", "biome", "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        graphql = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
    })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
  init = function()
    vim.o.formatexpr = "v.lua.require'conform'.formatexpr()"
  end
}
