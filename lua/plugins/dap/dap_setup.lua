local M = {}

local function config_js ()
  local get_config = require('plugins.dap.dap_configs.vscode_js')
  require("dap-vscode-js").setup({
    debugger_path = vim.fn.expand('$HOME') .. '/Progfiles/microsoft/vscode-js-debug',
    adapters = {
      'pwa-node',
      'pwa-chrome',
      'pwa-msedge',
      'node-terminal',
      'pwa-extensionHost'
    },
  })

  for _, language in ipairs({ "typescript", "javascript" }) do
    local opt = get_config({ 'launch', 'test', 'ts-node' })
    require("dap").configurations[language] = opt
  end
end

M.config = function()
  --"cppdbg"-or "codelldb"
  local adapters = { "python", "lua", "codelldb", "vscode_js"} --list your adapters here
  for _, adapter in ipairs(adapters) do
    require("plugins.dap.dap_configs." .. adapter)
  end
  config_js()
end

M.config_dapui = function ()
  local dap, dapui = require("dap"), require("dapui")

  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
end

return M
