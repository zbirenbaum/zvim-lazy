local plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      require('colors.tokyonight').setup()
    end
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
  },
  {
    "willothy/flatten.nvim",
    opts = require('plugins.other.flatten'),
    cond = function ()
      return not os.getenv("NVIM") ~= nil
    end,
    lazy = false,
    priority = 1001,
  },
  { "lewis6991/impatient.nvim"},
  {
    'kevinhwang91/nvim-ufo',
    event = 'LspAttach',
    dependencies ='kevinhwang91/promise-async'
  },
  {
    "nvim-tree/nvim-tree.lua",
    keys = { '<leader>n' },
    config = function ()
      require('plugins.other.nvim_tree')
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { 'pyright', 'bashls' }
      })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    config = function ()
      vim.g.rustaceanvim = function()
        -- Update this path
        local mason_path = vim.fn.stdpath("data") .. "/mason"
        local ext_path = mason_path .. "/packages/codelldb/extension"
        -- local bin = mason_path .. "/bin/codelldb"

        -- Update this path
        local codelldb_path = ext_path .. '/adapter/codelldb'
        local liblldb_path = ext_path .. '/lldb/lib/liblldb.so'
        local this_os = vim.uv.os_uname().sysname;
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
        local cfg = require('rustaceanvim.config')
        return {
          dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
          },
        }
      end
    end,
    ft = { 'rust' },
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = {"Telescope"},
    keys = { '<leader>ff', '<leader>fg', '<leader>fG' },
    config = function()
      require("plugins.other.telescope")
    end,
  },
  {"nvim-telescope/telescope-fzy-native.nvim"},
  {
    "ggandor/flit.nvim",
    -- disable = false,
    keys = function ()
      return vim.tbl_map(function(key)
        return { key, mode = { "n", "v", "x", "o" } }
      end, { 'f', 'F', 't', 'T' })
    end,
    config = function()
      require('flit').setup({
        multiline = true,
        labeled_modes = "nv"
      })
    end,
  },
  {
    "ggandor/leap.nvim",
    keys = function ()
      return vim.tbl_map(function(key)
        return { key, mode = { "n", "v", "x", "o" } }
      end, {'x', 's', 'X', 'S'})
    end,
    commit='9857f64c869f83e36bcde036213c758fc435d9b2',
    config = function()
      require("plugins.other.leap")
    end,
    dependencies = { 'tpope/vim-repeat', },
  },
  {'tpope/vim-repeat'},
  -- LSP and Completion
  {
    "jose-elias-alvarez/typescript.nvim",
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    event = {'VimEnter'},
    config = function()
      require("plugins.lsp.lsp_init").setup_lsp()
    end,
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "zbirenbaum/copilot.lua",
    }
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    config = function()
      local luasnip = require("luasnip")
      luasnip.config.set_config({
        defaults = {
          history = true,
          updateevents = "TextChanged,TextChangedI",
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end,
  },
  -- {
  --   "zbirenbaum/neodim",
  --   event = {"LspAttach"},
  --   config = function ()
  --     require("neodim").setup()
  --   end
  -- },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CursorHold" },
    config = function()
      require("plugins.completion.cmp_configs.cmp")
    end,
    dependencies = {
      "folke/neodev.nvim",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("plugins.completion.cmp_configs.lspsignature_cmp")
    end,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        library = {
          -- plugins = { "nvim-dap-ui" }, types = true
          plugins = false
        }
      })
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = {"Trouble", "TroubleToggle", "TroubleRefresh", "TroubleClose"},
    lazy = true,
    config = function()
      require("plugins.other.trouble")
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function ()
      require("nvim-surround").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.completion.autopairs")
    end,
  },
  {
    "NvChad/nvterm",
    keys = {'<C-l>', '<A-h>', '<A-v>', '<A-i>'},
    config = function ()
      require('nvterm').setup()
      require('utils.mappings').terminal()
    end
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("plugins.other.better_escape")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugins.other.treesitter")
    end,
    dependencies = {'nvim-treesitter/playground'},
  },
  {
    "numToStr/Comment.nvim",
    keys = { "gcc", "<leader>/" },
    lazy = false,
    config = function()
      require('utils.mappings').comment()
      require("Comment").setup()
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    config = function()
      require("plugins.other.neorg")
    end,
    dependencies={'kyazdani42/nvim-web-devicons', 'nvim-lua/plenary.nvim'}
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
    config = function()
      require("plugins.other.icons").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    commit = '9637670896b68805430e2f72cf5d16be5b97a22a',
    -- main = "ibl",
    config = function()
      require("plugins.other.indent_blankline")
    end,
  },
  {
    "feline-nvim/feline.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.other.feline")
    end,
  },
  {
    "gennaro-tedesco/nvim-jqx",
    cmd = {"JqxList", "JqxQuery"},
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.other.gitsigns")
    end,
  },
  {
    "monkoose/matchparen.nvim",
    config = function()
      require("matchparen").setup({})
    end,
  },
  {
    "zbirenbaum/nvim-base16.lua",
    config = function()
      -- require("colors").init('onedark')
    end,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
      "<Leader>b",
      "<C-o>",
      "<C-O>",
      "<C-n>",
      "<Leader>r",
      "<Leader>c",
    },
    config = function ()
      require("plugins.dap.dap_setup").config()
      require("utils.mappings").debug()
    end,
  },
  -- {
  --   'rcarriga/nvim-dap-ui',
  --   lazy=true,
  --   config = function()
  --     require('dapui').setup()
  --     require('plugins.dap.dap_setup').config_dapui()
  --   end
  -- },
  { "jbyuki/one-small-step-for-vimkind", lazy = true },
  { "mxsdev/nvim-dap-vscode-js", lazy = true },
}

return plugins
