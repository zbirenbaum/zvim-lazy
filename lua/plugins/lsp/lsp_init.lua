local M = {}

local default_lsp_config = function(attach, capabilities)
  local default_config = {
    on_attach = attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
  return default_config
end

M.setup_lsp = function()
  local lsp_setup = require("plugins.lsp.nvim_lsp_setup")
  lsp_setup.config_handlers()
  local attach = lsp_setup.attach()
  local capabilities = lsp_setup.setup_capabilities()
  local default_servers = { "gopls", "ts_ls", "basedpyright" }
  local custom_servers = {
    -- "graphql",
    "solidity",
    -- "eslint",
    "lua_ls",
    "bashls",
    "basedpyright",
    -- "ty",
    -- "pyright",
    -- "pylance",
    "ccls",
    -- "pylyzer",
    "clangd",
    -- "rust_analyzer",
    "html",
    "arduino_language_server",
    "prismals",
    "vtsls"
  }
  -- local has_plugin, _ = pcall(require, 'typescript')
  -- if has_plugin then
    -- require('typescript').setup({ server = { on_attach = attach } })
  -- end
  -- table.insert(custom_servers, package_installed('vue') and 'volar' or 'tsserver')
  local default_config = default_lsp_config(attach, capabilities)
  for _, lsp in ipairs(custom_servers) do
    local present, config = pcall(require, "plugins.lsp.lsp_configs." .. lsp)
    if present then
      vim.lsp.config(lsp, config.config_table(attach, capabilities))
    else
      vim.lsp.config(lsp, default_config)
    end
  end
  for _, lsp in ipairs(default_servers) do
      vim.lsp.config(lsp, default_config)
  end
end

-- require('plugins.lsptest')

return M
