return {
  "nvim-lua/plenary.nvim",
  { "ellisonleao/gruvbox.nvim", lazy = true,        priority = 1000 },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = {
      ensure_installed = {
        "stylua",
        "prettierd",
      }
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local registry = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local package = registry.get_package(tool)
          if not package:is_installed() then
            package:install()
          end
        end
      end
      if registry.refresh then
        registry.refresh(ensure_installed)
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "telescope.nvim",
      "jose-elias-alvarez/typescript.nvim"
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          local builtin = require("telescope.builtin")
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
          vim.keymap.set("n", "gy", builtin.lsp_type_definitions, opts)
          vim.keymap.set("n", "gr", builtin.lsp_references, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]e", function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
          end, opts)
          vim.keymap.set("n", "[e", function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
          end, opts)
          vim.keymap.set("n", "]w", function()
            vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
          end, opts)
          vim.keymap.set("n", "[w", function()
            vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
          end, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>cA",
            function()
              vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {}, } })
            end, opts
          )
          vim.keymap.set("n", "<leader>L", "<cmd>LspInfo<cr>", opts)

          -- disable semantic tokens for omnisharp
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local function toSnakeCase(str)
            return string.gsub(str, "%s*[- ]%s*", "_")
          end

          if client.name == 'omnisharp' then
            local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
            for i, v in ipairs(tokenModifiers) do
              tokenModifiers[i] = toSnakeCase(v)
            end
            local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
            for i, v in ipairs(tokenTypes) do
              tokenTypes[i] = toSnakeCase(v)
            end
          end
        end,
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
      )

      local default_capabilities = vim.lsp.protocol.make_client_capabilities()
      default_capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
          },
        },
      }
      default_capabilities = vim.tbl_deep_extend(
        "force",
        default_capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
            },
          },
        },
        omnisharp = {
          organize_imports_on_format = true,
        },
        tsserver = {},
        eslint = {},
        html = {},
        cssls = {},
        jsonls = {}
      }
      local function setup_server(server)
        local server_opts = vim.tbl_deep_extend(
          "force",
          { capabilities = vim.deepcopy(default_capabilities) },
          servers[server] or {}
        )
        if server == "tsserver" then
          require("typescript").setup({ server = server_opts })
        else
          require("lspconfig")[server].setup(server_opts)
        end
      end

      local ensure_installed = {}
      for server, _ in pairs(servers) do
        ensure_installed[#ensure_installed + 1] = server
      end
      local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
      if has_mason_lspconfig then
        mason_lspconfig.setup({ ensure_installed = ensure_installed })
        mason_lspconfig.setup_handlers({ setup_server })
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim", "typescript.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier.with {
            prefer_local = "node_modules/.bin"
          },
          require("typescript.extensions.null-ls.code-actions"),
        },
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              path = "[Path]",
            })
          })
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },
  { "echasnovski/mini.pairs",   event = "VeryLazy", version = "*",  opts = {} },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gza",
        delete = "gzd",
        find = "gzf",
        find_left = "gzF",
        highlight = "gzh",
        replace = "gzr",
        update_n_lines = "gzn",
      }
    },
  },
  {
    "echasnovski/mini.comment",
    version = "*",
    event = "VeryLazy",
    opts = {}
  },
  {
    "echasnovski/mini.ai",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 100,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c_sharp",
        "clojure",
        "css",
        "dockerfile",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "regex",
        "rust",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    }
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
          }
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer"
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
          }
        }
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = function()
      local has_telescope, builtin = pcall(require, "telescope.builtin")

      if not has_telescope then
        return {}
      end

      return {
        { "<leader>/",  builtin.live_grep,                                             desc = "Grep" },
        { "<leader>,",  function() builtin.buffers({ show_all_buffers = true }) end,   desc = "Buffers" },
        { "<leader>ff", builtin.find_files,                                            desc = "Find Files" },
        { "<leader>fr", builtin.oldfiles,                                              desc = "Recent" },
        { "<leader>fR", function() builtin.oldfiles({ only_cwd = true }) end,          desc = "Recent (cwd)" },
        { "<leader>gb", builtin.git_branchs,                                           desc = "Git Branches" },
        { "<leader>gc", builtin.git_commits,                                           desc = "Git Buffer Commits" },
        { "<leader>gC", builtin.git_commits,                                           desc = "Git Commits" },
        { "<leader>gs", builtin.git_status,                                            desc = "Git Status" },
        { "<leader>gS", builtin.git_stash,                                             desc = "Git Stash" },
        { "<leader>sa", builtin.autocommands,                                          desc = "Autocommands" },
        { "<leader>sb", builtin.buffers,                                               desc = "Buffers" },
        { "<leader>sc", builtin.commands,                                              desc = "Commands" },
        { "<leader>sC", builtin.command_history,                                       desc = "Command History" },
        { "<leader>sd", function() builtin.diagnostics({ bufnr = 0 }) end,             desc = "Document Diagnostics" },
        { "<leader>sD", builtin.diagnostics,                                           desc = "Workspace Diagnostics" },
        { "<leader>sh", builtin.help_tags,                                             desc = "Help" },
        { "<leader>sH", builtin.highlights,                                            desc = "Hilights" },
        { "<leader>sj", builtin.jumplist,                                              desc = "Jumplist" },
        { "<leader>sk", builtin.keymaps,                                               desc = "Keymaps" },
        { "<leader>sm", builtin.marks,                                                 desc = "Marks" },
        { "<leader>sM", builtin.man_pages,                                             desc = "Man Pages" },
        { "<leader>so", builtin.vim_options,                                           desc = "Vim Options" },
        { "<leader>sr", builtin.registers,                                             desc = "Registers" },
        { "<leader>sR", builtin.resume,                                                desc = "Resume" },
        { "<leader>st", builtin.tags,                                                  desc = "Tags" },
        { "<leader>sT", function() builtin.colorscheme({ enable_preview = true }) end, desc = "Colorscheme" },
      }
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return {
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>hd", gs.diffthis, "Diff This")
          map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end
      }
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = function()
      local icons = require("config").icons
      return {
        options = {
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.error,
                warn = icons.diagnostics.warn,
                info = icons.diagnostics.info,
                hint = icons.diagnostics.hint,
              }
            },
            {
              "filetype",
              icon_only = true,
              separator = "",
              padding = {
                left = 1, right = 0 }
            },
            { "filename", path = 1, symbols = { modified = " ", readonly = "", unnamed = "" } },
            "encoding",
          },
          lualine_x = {
            {
              require("noice").api.status.command.get,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = { fg = "#ff9e64" },
            },
            {
              require("noice").api.status.mode.get,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = { fg = "#ff9e64" },
            },
            "diff",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        tabline = {
          lualine_a = { { "buffers", symbols = { alternate_file = "# " } } },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "plenary.nvim",
      "nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e",  "<cmd>Neotree source=filesystem position=left reveal=true<cr>",  desc = "Explorer" },
      { "<leader>ge", "<cmd>Neotree source=git_status position=float reveal=true<cr>", desc = "Git Status" }
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    opts = {
      close_if_last_window = true,
      default_component_configs = {
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
        },
        git_status = {
          symbols = {
            renamed  = "󰁕",
            unstaged = "󰄱",
          },
        },
      },
      document_symbols = {
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Property = { icon = "󰆧", hl = "@property" },
          Enum = { icon = "󰒻", hl = "@number" },
          Function = { icon = "󰊕", hl = "Function" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Struct = { icon = "󰌗", hl = "Type" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
          StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        }
      },
      source_selector = {
        sources = {
          { source = "filesystem", display_name = " 󰉓 Files " },
          { source = "git_status", display_name = " 󰊢 Git " },
        },
      },
    },
    config = function(_, opts)
      local icons = require("config").icons

      vim.fn.sign_define("DiagnosticSignError",
        { text = icons.diagnostics.error, texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",
        { text = icons.diagnostics.warn, texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo",
        { text = icons.diagnostics.info, texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint",
        { text = icons.diagnostics.hint, texthl = "DiagnosticSignHint" })

      require("neo-tree").setup(opts)
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "nui.nvim",
      "rcarriga/nvim-notify"
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        }
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      }
    }
  },
  {
    "stevearc/dressing.nvim",
    opts = {}
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetype_exclude = { "checkhealth", "help", "man", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      show_current_context = true,
    },
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "ggandor/flit.nvim",
    keys = function()
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  { "tpope/vim-repeat", event = "VeryLazy" },
}
