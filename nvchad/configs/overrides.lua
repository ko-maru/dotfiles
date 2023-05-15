local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "c_sharp",
    "clojure",
    "css",
    "vim",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "make",
    "rust",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- LSP
    "bash-language-server",
    "css-lsp",
    "deno",
    "docker-file-language-server",
    "emmet-ls",
    "eslint-lsp",
    "json-ls",
    "html-lsp",
    "lua-language-server",
    "omnisharp",
    "sqlls",
    "typescript-language-server",
    "yaml-language-server",
    -- Linter or Linter
    "markdown",
    "prettierd",
    "stylua",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
