local util = require 'lspconfig.util'
local mason = vim.fn.stdpath("data") .. "/mason/" .. "bin/"
local bin_name = "/home/zach/.local/bin/arduino-language-server"
local cmd = {
  bin_name,
  "-cli", "/home/zach/.local/bin/arduino-cli",
  "-fqbn", "arduino:avr:nano"
}

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
default_capabilities.textDocument.semanticTokens = vim.NIL
default_capabilities.workspace.semanticTokens = vim.NIL

return {
  config_table = function (attach, capabilities)
    return {
      filetypes = { 'arduino' },
      root_dir = util.root_pattern '*.ino',
      cmd = cmd,
      capabilities = default_capabilities,
    }
  end
}
