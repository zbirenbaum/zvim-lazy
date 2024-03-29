local util = require 'lspconfig.util'
local mason_dir = vim.fn.stdpath('data')

-- local bin_name = mason_dir .. '/typescript-language-server'
local bin_name = mason_dir .. '/typescript-language-server'
local cmd = { bin_name, '--stdio' }

local M = {}

M.config_table = function(attach, capabilities)
  return {
    init_options = {
      hostInfo = 'neovim',
      logVerbosity = 'verbose',
      preferences = {
			  includeCompletionsForModuleExports = false,
        -- disableSuggestions = true,
        -- noGetErrOnBackgroundUpdate = true,
      },
    },
    cmd = cmd,
    on_attach = attach,
    capabilities = capabilities,
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    on_init = function ()
    end,
    root_dir = function(fname)
      return (util.root_pattern 'tsconfig.json'(fname)
        or util.root_pattern('package.json', 'jsconfig.json', '.git')(fname))
        -- not util.root_pattern('vite.config.ts')(fname) or nil
    end,
  }
end

return M
