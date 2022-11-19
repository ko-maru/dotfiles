require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'c_sharp',
    'css',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'rust',
    'scss',
    'sql',
    'toml',
    'typescript',
    'yaml'
  },
  highlight = {
    enable = true
  }
}
