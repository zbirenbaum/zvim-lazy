local dap = require("dap")


dap.adapters.codelldb = {
  type = 'server',
  port = "13000",
  executable = {
    command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb',
    args = {"--port", "13000"},
  }
}

local standard_cfg = {
  name = "Launch file",
  type = "codelldb",
  request = "launch",
  program = function()
    return '/home/zach/Dev/tracemachina/nativelink/target/debug/deps/filesystem_store_test-cbada86aad1fcc16'
    -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  end,
  cwd = '${workspaceFolder}',
  stopOnEntry = false,
}

dap.configurations.cpp = { standard_cfg }
dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = {
  vim.tbl_deep_extend('force', standard_cfg, {
    initCommands = function()
      -- Find out where to look for the pretty printer Python module
      local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

      local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
      local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

      local commands = {}
      local file = io.open(commands_file, 'r')
      if file then
        for line in file:lines() do
          table.insert(commands, line)
        end
        file:close()
      end
      table.insert(commands, 1, script_import)

      return commands
    end,
  })
}
