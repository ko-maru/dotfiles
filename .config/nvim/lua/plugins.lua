local fn = vim.fn

-- Automatically install packer.nvim
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand to reload plugins.lua file on save
local packer_augroup = vim.api.nvim_create_augroup('packer', {})
vim.api.nvim_create_autocmd(
  'BufWritePost',
  {
    group = packer_augroup,
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile'
  }
)

-- Include 'packer' module
local ok, packer = pcall(require, 'packer')
if not ok then
  print "packer.nvim does not exist"
  return
end

-- Use popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Install plugins
return packer.startup(function(use)
  -- Plugin manager
  use { 'wbthomason/packer.nvim' }
  -- Library
  use "nvim-lua/plenary.nvim"
  -- Icon
  use { "kyazdani42/nvim-web-devicons", opt = true }
  -- Colorscheme
  use { 'cocopon/iceberg.vim' }
  use { 'EdenEast/nightfox.nvim' }
  use { "ellisonleao/gruvbox.nvim" }
  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    config = 'require "plugin/lualine"',
  }
  -- LSP Configuration
  use { 'neovim/nvim-lspconfig', config = 'require "plugin/lspconfig"' }
  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'
  -- Autocompletion
  use { 'hrsh7th/nvim-cmp', config = 'require "plugin/nvim-cmp"' }
  -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  -- LSP UI
  use { 'kkharji/lspsaga.nvim', config = 'require("plugin/lspsaga")'}
  -- Package manager for LSP servers, DAP servers, linters and formatters
  use { "williamboman/mason.nvim", config = 'require("plugin/mason")' }
  use "williamboman/mason-lspconfig.nvim"
  -- Automatically creates missing LSP diagnostics highlight groups for color schemes
  use 'folke/lsp-colors.nvim'
  use {
    "folke/trouble.nvim",
    config = 'require("plugin/trouble")'
  }
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = 'require("plugin/treesitter")'
  }
  -- Fuzzy finder
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    config = 'require("plugin/telescope")'
  }
  -- Git
  use { 'tpope/vim-fugitive' }
  use {
    'lewis6991/gitsigns.nvim',
    config = 'require("plugin/gitsigns")'
  }


  if PACKER_BOOTSTRAP then
    packer.sync()
  end
end)
