local keymap = vim.keymap.set
local opts = { noremap=true, silent=true }

keymap('n', 'gd', vim.lsp.buf.definition, opts)
keymap('n', 'gi', vim.lsp.buf.implementation, opts)
keymap('n', 'gf', function() vim.lsp.buf.format { async = true } end, opts)
keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
keymap('n', '<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)

-- Disable virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

-- Additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require 'lspconfig'

lspconfig.tsserver.setup {
  capabilities = capabilities
}

lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  capabilities = capabilities
}
