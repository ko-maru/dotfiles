-- install packer automatically
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'plugins.lua' })

function get_config(name)
  return string.format('require("plugins/%s")', name)
end

-- install plugins 
require('packer').startup(function(use)
  -- package manager
  use 'wbthomason/packer.nvim'

  -- file explorer
  use {
    'lambdalisue/fern.vim',
    'lambdalisue/fern-hijack.vim',
    'lambdalisue/fern-git-status.vim',
    {
      'lambdalisue/fern-renderer-nerdfont.vim',
      requires = { 'lambdalisue/nerdfont.vim' }
    }
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = get_config('trouble')
  }


  -- theme
  use {
    'cocopon/iceberg.vim', 
    config =  function()
      vim.cmd[[colorscheme iceberg]]
    end
  }

  use { 
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true },
    config = get_config('lualine')
  }

  use { 
    'neovim/nvim-lspconfig',
    config = get_config('nvim-lspconfig')
  }
  use 'williamboman/nvim-lsp-installer'

  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-cmdline'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lsp-signature-help'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'}
    },
    config = get_config('nvim-cmp')
  }

  use 'editorconfig/editorconfig-vim'
  use 'norcalli/nvim-colorizer.lua'
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'machakann/vim-sandwich'
  use { 
    'mattn/emmet-vim', 
    ft = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, 
    config = function()
      vim.cmd[[EmmetInstall]]
    end
  }

  use { 
    'nvim-telescope/telescope.nvim', 
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'BurntSushi/ripgrep', opt = true },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = get_config('telescope')
  }

  use {
    'nvim-treesitter/nvim-treesitter', 
    run = ':TSUpdate',
    requires = {
     'nvim-treesitter/nvim-treesitter-textobjects'
    },
    config = get_config('nvim-treesitter')
  }

  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- fern
vim.keymap.set('n', '<leader>e', ":Fern . -drawer -toggle -reveal=%<CR>", { noremap=true, silent=true })

vim.g['fern#default_hidden'] = 1
vim.g['fern#renderer'] = "nerdfont"

-- EditorConfig
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }

require('colorizer').setup()

-- Comment
require('Comment').setup() 

-- LSP settings
require('nvim-lsp-installer').setup {
  automatic_installation = true
}

