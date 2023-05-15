---@type ChadrcConfig
local M = {}

local highlights = require "custom.highlights"

M.ui = {
	theme = "everforest",
	theme_toggle = { "everforest", "everforest_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,

 statusline = {
    theme = "vscode_colored",
  },

  nvdash = {
    header = {
      " _      ______          _____  ",
      "| |    |  ____|   /\\   |  __ \\ ",
      "| |    | |__     /  \\  | |  | |",
      "| |    |  __|   / /\\ \\ | |  | |",
      "| |____| |____ / ____ \\| |__| |",
      "|______|______/_/    \\_\\_____/ ",
    }
  }
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")



return M
