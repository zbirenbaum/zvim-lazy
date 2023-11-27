local M = {}

M.config_table = function(attach, capabilities)
  require('neodev').setup({
    library = {
      plugins = false,
    }
  })
  local mason_path = vim.fn.stdpath("data") .. "/mason"
  --local sumneko_root_path = vim.fn.getenv "HOME" .. "/sumneko_lua"
  local cmd = mason_path .. '/bin/lua-language-server' --/usr/share/lua-language-server"
  -- local sumneko_binary = "/usr/bin/lua-language-server"

  return {

    cmd = { cmd },
    -- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    on_attach = attach,
    capabilities = capabilities,
    completion = { callSnippet = "Both" },
    flags = {
      debounce_text_changes = 300,
    },
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false,
          preloadFileSize = 10000,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

return M
