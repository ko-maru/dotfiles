return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "}c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end)
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "{c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end)

      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage hunk" })
      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset hunk" })

      map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Unstage hunk" })
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Blame line" })
      map("n", "<leader>htb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
      map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })
      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, { desc = "Diff this ~" })
      map("n", "<leader>htd", gitsigns.toggle_deleted)

      map({ "o", "x" }, "ih", ":<c-u>Gitsigns select_hunk<cr>", { desc = "Select hunk" })
    end,
  },
}
