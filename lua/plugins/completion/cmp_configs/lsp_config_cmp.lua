local lspconfig = require("lspconfig")
local default_servers = { "clangd" }
local custom_servers = { "pylance", "lua_ls" }

local M = {}

M.setup_lsp = function(attach, capabilities)
  for _, lsp in ipairs(custom_servers) do
    require("plugins.lsp_configs.cmp." .. lsp).setup(attach, capabilities)
  end

  for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    })
  end
end

return M
