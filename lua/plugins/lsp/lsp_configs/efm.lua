local util = require 'lspconfig.util'
local mason_dir = vim.fn.stdpath('data') .. "/mason/bin"
local bin_name = mason_dir .. '/efm-langserver'

local prettier_bin = mason_dir .. '/prettierd'
local eslint_bin = mason_dir .. '/eslint_d'
local ts_generic_config = {
    {
      formatCommand = prettier_bin .. " ${INPUT}",
      formatStdin = true,
      env = { PRETTIERD_LOCAL_PRETTIER_ONLY='true' }
    },
    {
      formatCommand = eslint_bin .. " --fix-to-stdout --stdin --stdin-filename=${INPUT}",
      formatStdin = true,
      env = {
      "ESLINT_D_LOCAL_ESLINT_ONLY=true"
    }
  },
}
return {
  config_table = function (attach, _)
    return {
      init_options = {documentFormatting = true},
      root_dir = util.find_git_ancestor,
      single_file_support = true,
      on_attach = attach,
      cmd = { bin_name },
      filetypes = {
        'lua',
        'typescript',
        'typescriptreact',
        'javascript',
      },
      settings = {
        rootMarkers = {".git/", "package.json" },
        languages = {
          lua = {
            {formatCommand = "lua-format -i", formatStdin = true}
          },
          typescript = ts_generic_config,
          typescriptreact = ts_generic_config,
        }
      }
    }
  end
}
