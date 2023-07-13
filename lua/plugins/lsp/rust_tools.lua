local rt = require("rust-tools")

local mason_path = vim.fn.stdpath("data") .. "/mason"
local ext_path = mason_path .. "/packages/codelldb/extension"
-- local bin = mason_path .. "/bin/codelldb"

-- Update this path
local codelldb_path = ext_path .. '/adapter/codelldb'
local liblldb_path = ext_path .. '/lldb/lib/liblldb.so'
local opts = {
  tools = {
    hover_actions = {
      -- whether the hover action window gets automatically focused
      auto_focus = false,
    },
  },
  server = {
    cmd = { 'rust-analyzer' },
    on_attach = function(_, bufnr)
      require("dap")
      require("dapui")
      -- Hover actions
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      -- vim.keymap.set("n", "<Space>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          enable = true,
          command = "clippy",
        },
        cargo = {
          allFeatures = true,
        },
      },
    },
  },
  dap = {
    adapter = require(
      "rust-tools.dap"
    ).get_codelldb_adapter(codelldb_path, liblldb_path),
  },
}

rt.setup(opts)
