vim.keymap.set('n', '<C-e>', ":Fern . -drawer -toggle -reveal=%<CR>", { noremap=true, silent=true })

vim.g['fern#default_hidden'] = 1
vim.g['fern#renderer'] = "nerdfont"
