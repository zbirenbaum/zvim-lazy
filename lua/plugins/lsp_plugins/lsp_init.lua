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

local M = {}

M.setup_lsp = function(completion_engine)
  local lsp_setup = require("plugins.lsp_plugins.nvim_lsp_setup")
  lsp_setup.config_handlers()
  local attach = lsp_setup.attach()
  local capabilities = lsp_setup.setup_capabilities()
  if not completion_engine then
    completion_engine = {}
  end
  local lspconfig = require("lspconfig")
  local default_servers = { "gopls" }
  local custom_servers = {
    "hardhat_vscode",
    "eslint",
    "sumneko_lua",
    "bashls",
    -- "pylance",
    "pyright",
    "clangd",
    "rust_analyzer",
    "html",
  }
  local has_plugin, _ = pcall(require, 'typescript')
  if has_plugin then
    require('typescript').setup({ server = { on_attach = attach } })
  end
  -- table.insert(custom_servers, package_installed('vue') and 'volar' or 'tsserver')
  local default_config = default_lsp_config(attach, capabilities)
  for _, lsp in ipairs(custom_servers) do
    local present, config = pcall(require, "plugins.lsp_plugins.lsp_configs." .. lsp)
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
