return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "nvimdev/lspsaga.nvim",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    require("lspsaga").setup({
      symbol_in_winbar = {
        show_file = false,
      },
    })

    local function aaa() end

    local lspconfig = require("lspconfig")
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local builtin = require("telescope.builtin")
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "List LSP references"
        vim.keymap.set("n", "gr", builtin.lsp_references, opts)

        opts.desc = "List LSP definitions"
        vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts)

        opts.desc = "List LSP type definitions"
        vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<cr>", opts)

        opts.desc = "List LSP implementations"
        vim.keymap.set("n", "gD", builtin.lsp_implementations, opts)

        opts.desc = "Show code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)

        opts.desc = "Rename symbol"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css" },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
