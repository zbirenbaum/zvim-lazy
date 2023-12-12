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
  require("lspconfig.configs").vtsls = require("vtsls").lspconfig -- set default server config, optional but recommended
  local lsp_setup = require("plugins.lsp.nvim_lsp_setup")
  lsp_setup.config_handlers()
  local attach = lsp_setup.attach()
  local capabilities = lsp_setup.setup_capabilities()
  local lspconfig = require("lspconfig")
  local default_servers = { "gopls" }
  local custom_servers = {
    "solidity",
    "lua_ls",
    "bashls",
    "pylance",
    "ccls",
    "clangd",
    "html",
    "arduino_language_server",
    "prismals",
    "vtsls"
    -- "efm",
    -- "graphql",
    -- "eslint",
    -- "pylyzer",
    -- "rust_analyzer",
    -- "tsserver",
  }
  local default_config = default_lsp_config(attach, capabilities)
  for _, lsp in ipairs(custom_servers) do
    local present, config = pcall(require, "plugins.lsp.lsp_configs." .. lsp)
    if present then
      lspconfig[lsp].setup(config.config_table(attach, capabilities))
    else
      lspconfig[lsp].setup(default_config)
    end
  end
  for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup(default_config)
  end
end

return M
