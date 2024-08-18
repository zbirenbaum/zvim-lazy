local M = {}
local colors = require('colors.scheme')

local capability_settings = {
  completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = {
      valueSet = { 1 }
    },
    resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits" }
    },
  },
}

M.setup_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local completionItem = capabilities.textDocument.completion.completionItem
  completionItem = vim.tbl_deep_extend("force", completionItem, capability_settings.completionItem)
  return capabilities
end

M.config_handlers = function()
    vim.api.nvim_create_user_command("ShowDiagnostic", function ()
        vim.diagnostic.open_float()
      end,
      {}
    )
  local config_diagnostics = function()
    -- local function lspSymbol(name, icon)
    --   local hl = "DiagnosticSign" .. name
    --   -- vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
    -- end

    vim.diagnostic.config({
      signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅙',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '󰋼',
            [vim.diagnostic.severity.HINT] = '󰌵'
          },
          -- linehl = {
          --   [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          -- },
          numhl = {
            [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
            [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
            [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
            [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
          },
      },
    })
    -- suppress error messages from lang servers
  end
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
  })
  config_diagnostics()

  vim.api.nvim_set_hl(0, "LspInlayHint", {fg=colors.grey_fg, bg='NONE', italic=true})
end

M.attach = function()
  local function attach(client, bufnr)
    require('plugins.completion.cmp_configs.lspsignature_cmp').setup(bufnr)
    -- client.server_capabilities.semanticTokensProvider = nil
    -- Enable completion triggered by <c-x><c-o>
    -- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    require("utils.mappings").lsp()
  end
  return attach
end

return M
