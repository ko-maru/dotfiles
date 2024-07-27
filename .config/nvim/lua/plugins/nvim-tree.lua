return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			renderer = {
				icons = {
					show = {
						file = false,
						folder = false,
						git = false,
						modified = false,
						hidden = false,
					},
				},
				group_empty = true,
			},
			filters = {
				dotfiles = true,
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		vim.keymap.set(
			"n",
			"<leader>e",
			":NvimTreeToggle<cr>",
			{ silent = true, noremap = true, desc = "Toggle file explorer" }
		)
	end,
}
