local M = {}
local util = require("lspconfig/util")

M.config_table = function(attach, capabilities)
  return {
    capabilities = capabilities,
    on_attach = attach,
    root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt"),
    flags = {
      debounce_text_changes = 1,
    },
    settings = {
      python = {
        analysis = {
          --stubPath = "./typings",
          autoSearchPaths = false,
          useLibraryCodeForTypes = false,
          diagnosticMode = "openFilesOnly",
        },
      },
    },
  }
end

return M
