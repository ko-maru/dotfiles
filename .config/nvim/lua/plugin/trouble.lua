local keymap = vim.keymap.set
local opt = { silent = true, noremap = true }
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opt)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opt)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opt)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opt)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opt)
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opt)
