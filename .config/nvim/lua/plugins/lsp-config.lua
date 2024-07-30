return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "nvimdev/lspsaga.nvim",
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    require("lspsaga").setup({
      symbol_in_winbar = {
        show_file = false,
      },
    })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local builtin = require("telescope.builtin")
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "List LSP references"
        vim.keymap.set("n", "gr", builtin.lsp_references, opts)

        opts.desc = "List LSP definitions"
        vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)

        opts.desc = "List LSP type definitions"
        vim.keymap.set("n", "gy", builtin.lsp_type_definitions, opts)

        opts.desc = "List LSP implementations"
        vim.keymap.set("n", "gI", builtin.lsp_implementations, opts)

        opts.desc = "Show code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)

        opts.desc = "Rename symbol"
        vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)

        opts.desc = "Jump to the next diagnostics"
        vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)

        opts.desc = "Jump to the previous diagnostics"
        vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)

        opts.desc = "Hover document"
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
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
