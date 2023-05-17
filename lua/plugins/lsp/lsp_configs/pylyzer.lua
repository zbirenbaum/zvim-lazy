local M = {}
local util = require("lspconfig/util")

M.config_table = function(attach, capabilities)
  return {
    capabilities = capabilities,
    cmd = {'pylyzer', '--server' },
    on_attach = attach,
    root_dir = util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt"),
    settings = {
      python = {
        checkOnType=false,
        diagnostics = true,
        inlayHints = true,
        smartCompletion = true
      },
    },
  }
end

return M
