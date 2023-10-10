local util = require('lspconfig.util')
local mason = vim.fn.stdpath("data") .. "/mason/" .. "bin"
local bin_name = mason .. '/prisma-language-server'

local M = {}

M.config_table = function(attach, capabilities)
  return {
    cmd = { bin_name, '--stdio' },
    on_attach = attach,
    capabilities = capabilities,
    filetypes = { 'prisma' },
    settings = {
      prisma = {
        prismaFmtBinPath = '',
      },
    },
    root_dir = util.root_pattern('.git', 'package.json'),
  }
end

return M
