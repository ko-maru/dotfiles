-- Diagnostic keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)


local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)

  vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)

  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>=', vim.lsp.buf.formatting, opts)

  vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = {
  'bashls',
  'cssls',
  'dockerls',
  'eslint',
  'html',
  'jsonls',
  'rust_analyzer', 
  'stylelint_lsp',
  'sumneko_lua',
  'tsserver',
  'vimls',
  'yamlls'
}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

