local lspconfig = require("lspconfig")
local default_servers = { "clangd" }
local custom_servers = { "pylance", "lua_ls" }

local M = {}

M.setup_lsp = function(attach, capabilities)
  local blink_capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

  for _, lsp in ipairs(custom_servers) do
    require("plugins.lsp_configs.cmp." .. lsp).setup(attach, blink_capabilities)
  end

  for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
      on_attach = attach,
      capabilities = blink_capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    })
  end
end

return M
