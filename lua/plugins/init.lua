local plugins = {
  { "lewis6991/impatient.nvim"},
  { "wbthomason/packer.nvim"},
  {
    'kevinhwang91/nvim-ufo',
    event = 'LspAttach',
    dependencies ='kevinhwang91/promise-async'
  },
  {
    "nvim-tree/nvim-tree.lua",
    keys = { '<A-n>' },
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
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = {"Telescope"},
    keys = { '<leader>ff', '<leader>fg', },
    config = function()
      require("plugins.other.telescope")
    end,
  },
  { "nvim-telescope/telescope-fzy-native.nvim"},
  {
    "ggandor/flit.nvim",
    -- disable = false,
    keys = { 'f', 'F', 't', 'T' },
    config = function()
      require('flit').setup({
        multiline = true,
        labeled_modes = "nv"
      })
    end,
  },
  {
    "ggandor/leap.nvim",
    keys = {'x', 's', 'X', 'S'},
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
        suggestion = { enabled = false },
        panel = {
          enabled = true,
          layout = {
            position = "bottom",
            size = 0.4
          }
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
  {
    "zbirenbaum/neodim",
    event = {"LspAttach"},
    config = function ()
      require("neodim").setup()
    end
  },
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
          plugins = false,
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
    config = function()
      require("plugins.other.neorg")
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
    "nvim-lua/plenary.nvim"
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
      require("colors").init('onedark')
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
  { "jbyuki/one-small-step-for-vimkind", lazy = true },
  { "mxsdev/nvim-dap-vscode-js", lazy = true },
}

return plugins
