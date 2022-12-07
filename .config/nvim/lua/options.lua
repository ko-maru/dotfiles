-- Judge the feature is supported.
local function has(feature)
  return vim.fn.has(feature) == 1
end

if has('unnamedplus')  then
  vim.opt.clipboard:prepend { 'unnamedplus' }
end
vim.opt.clipboard:prepend { 'unnamed' }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = { tab = '>-', trail = '-', nbsp = '+' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.formatoptions:append { 'r' }
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 2
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.virtualedit = { 'onemore' }
vim.opt.whichwrap:append { ['<'] = true, ['>'] = true }
vim.opt.wildmode = { 'list:longest', 'full' }

