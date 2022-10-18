-- install packer automatically
local ensure_packer = function()
  local fn = vim.fn
  local install_path = vim.fn.stdpath 'data'..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'plugins.lua' })

function get_config(name)
  return string.format('require("plugins/%s")', name)
end

require('packer').startup(function(use)
  -- package manager
  use 'wbthomason/packer.nvim'
  -- colorscheme
  use { 'mhartington/oceanic-next', config = function() vim.cmd[[colorscheme OceanicNext]] end }
  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = get_config('lualine')
  }
  -- language server manager
  use { "williamboman/mason.nvim", config = function() require('mason').setup() end }
  use {
    "williamboman/mason-lspconfig.nvim",
    config = function() require('mason-lspconfig').setup() end
  }
  -- LSP config
  use { 'neovim/nvim-lspconfig', config = get_config('nvim-lspconfig') }
  use { 
    "jose-elias-alvarez/null-ls.nvim", 
    requires = { "nvim-lua/plenary.nvim" },
    config = get_config('null-ls')
  }
  -- snippet
  use 'L3MON4D3/LuaSnip'
  -- autocompletion 
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-cmdline'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'}
    },
    config = get_config('nvim-cmp')
  }
  -- icons
  use 'kyazdani42/nvim-web-devicons'
  -- trouble
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = get_config('trouble')
  }
  -- file explorer
  use {
    {'lambdalisue/fern.vim', config = get_config('fern') },
    'lambdalisue/fern-hijack.vim',
    'lambdalisue/fern-git-status.vim',
    {
      'lambdalisue/fern-renderer-nerdfont.vim',
      requires = { 'lambdalisue/nerdfont.vim' }
    }
  }
  -- fuzzy finder
  use { 
    'nvim-telescope/telescope.nvim', 
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'BurntSushi/ripgrep', opt = true },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = get_config('telescope')
  }
  -- syntax highlight
  use {
    'nvim-treesitter/nvim-treesitter', 
    run = ':TSUpdate',
    config = get_config('nvim-treesitter')
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'norcalli/nvim-colorizer.lua'
  -- git
  use {
    'tpope/vim-fugitive',
    config = get_config('vim-fugitive')
  }
  use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }
  -- edit
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'machakann/vim-sandwich'
  use {
    'editorconfig/editorconfig-vim',
    config = function() vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' } end,
  }
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  -- markdown preview
  use { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

