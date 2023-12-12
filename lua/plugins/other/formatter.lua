-- Utilities for creating configurations
local util = require "formatter.util"

local filetype = {
  lua = {
    require("formatter.filetypes.lua").stylua,
    function ()
      return {
        exe = "stylua",
        args = { 
          "--search-parent-directories",
          "--stdin-filepath", 
          util.escape_path(util.get_current_buffer_file_path()), 
          "--",
          "-",
        },
        stdin = true,
      }
    end
  },
  typescript = {

  }
}
-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}
