local debugging = {}

function debugging.setup()
  local dap = require("dap")

  -- local sign = vim.diagnostic.config{
  -- {
  --
  --   }
  -- }
  --
  --
  -- signs = { text = { [vim.diagnostic.severity.ERROR] = 'E', } }
  --
  -- sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  -- -- These are to override the default highlight groups for catppuccin (see https://github.com/catppuccin/nvim/#special-integrations)
  -- sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
  -- sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
  -- sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

  local mason_registry = require("mason-registry")
  local cpp_dap_executable = mason_registry.get_package("cpptools"):get_install_path()
    .. "/extension/debugAdapters/bin/OpenDebugAD7"

  dap.adapters.cpp = {
    id = "cppdbg",
    type = "executable",
    command = cpp_dap_executable,
  }

  local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
  local codelldb_path = codelldb_root .. "adapter/codelldb"
  local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

  -- To use the venv for debugpy that is installed with mason, obtain the path and pass it to `setup` as shown below.
  -- I don't think this is the best idea right now, because it requires that the user installs the packages into a venv that they didn't create and may not know of.

  local debugpy_root = mason_registry.get_package("debugpy"):get_install_path()
  require("dap-python").setup(debugpy_root .. "/venv/bin/python")
  require("dap-python").test_runner = "pytest"

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
  }

  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  end

  require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = true,
    show_stop_reason = true,
    commented = vim.fn.has("nvim-0.10") ~= 1,
    only_first_definition = true,
    all_references = true,
    display_callback = function(variable, buf, stackframe, node, options)
      if options.virt_text_pos == "inline" then
        return " = " .. string.sub(variable.value, 1, 15)
      else
        return variable.name .. " = " .. variable.value
      end
    end,
    virt_text_pos = "eol", -- vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

    -- experimental features
    all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
  })

  local dapui = require("dapui")
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  -- dap.listeners.before.event_terminated["dapui_config"] = function()
  --   dapui.close()
  -- end
  -- dap.listeners.before.event_exited["dapui_config"] = function()
  --   dapui.close()
  -- end
end

return debugging
