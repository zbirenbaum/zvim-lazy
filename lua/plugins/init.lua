local plugins = {
  { "lewis6991/impatient.nvim"},
  { "wbthomason/packer.nvim"},
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
      require("plugins.custom_plugin_configs.telescope")
    end,
  },
  { "nvim-telescope/telescope-fzy-native.nvim"},
  {
   "ggandor/lightspeed.nvim",
    disable = true,
    keys = {'f', 's', 'F', 'S'},
    config = function ()
      require('plugins.custom_plugin_configs.lightspeed')
    end
  },
  {
   'phaazon/hop.nvim',
    disable = true,
    config = function()
      require('plugins.custom_plugin_configs.hop')
    end,
  },
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
    -- disable = false,
    keys = {'x', 's', 'X', 'S'},
    -- lazy = true,
    config = function()
      require("plugins.custom_plugin_configs.leap")
    end,
    dependencies = {
      'tpope/vim-repeat',
    },
  },
  -- LSP and Completion
  {
   "jose-elias-alvarez/typescript.nvim",
    lazy = true,
  },
  {
   "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp_plugins.lsp_init").setup_lsp('cmp')
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
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
    event = "VeryLazy",
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
      require("copilot_cmp").setup({
        clear_after_cursor=true,
      })
    end
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
      require("plugins.completion_plugins.cmp_configs.cmp")
    end,
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
  },
  {
   "ray-x/lsp_signature.nvim",
    lazy = true,
    config = function()
      require("plugins.completion_plugins.cmp_configs.lspsignature_cmp")
    end,
  },
  {
   "folke/lua-dev.nvim",
    ft = "lua",
    event = "VeryLazy"
  },
  {
   "bfredl/nvim-luadev",
    ft = "lua",
    cmd = { "Luadev" },
    event = "VeryLazy",
    config = function()
      vim.schedule(function()
        require("luadev")
      end)
    end,
  },
  {
   "folke/trouble.nvim",
    cmd = {"Trouble", "TroubleToggle", "TroubleRefresh", "TroubleClose"},
    lazy = true,
    config = function()
      require("plugins.custom_plugin_configs.trouble")
    end,
  },
  -- completion stuff
  {
   "kylechui/nvim-surround",
    config = function ()
      require("nvim-surround").setup()
    end,
  },
  {
   "windwp/nvim-autopairs",
    config = function()
      require("plugins.completion_plugins.autopairs")
    end,
  },

--   -- misc utils
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
      require("plugins.overrides.better_escape")
    end,
  },
  {
   "nvim-treesitter/nvim-treesitter",
    config = function()
      local setup = function() require("plugins.overrides.treesitter") end
      if vim.bo.filetype == 'norg' then setup() else vim.defer_fn(setup, 10) end
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
      require("plugins.custom_plugin_configs.neorg")
    end,
  },
  {
   "nvim-lua/plenary.nvim",
    lazy = true,
    "nvim-lua/plenary.nvim"
  },
  -- ui
  {
   "kyazdani42/nvim-web-devicons",
    lazy = true,
    config = function()
      require("plugins.overrides.icons").setup()
    end,
  },
  {
   "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
      vim.defer_fn(function()
        require("plugins.custom_plugin_configs.indent_blankline")
      end, 10)
    end,
  },
  {
   "feline-nvim/feline.nvim",
    event = "VeryLazy",
    config = function()
      vim.defer_fn(function()
        require("plugins.overrides.statusline_builder.builder")
      end, 25)
    end,
  },
  {
   "gennaro-tedesco/nvim-jqx",
    cmd = {"JqxList", "JqxQuery"},
  },
  {
   "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.overrides.gitsigns")
    end,
  },
  {
   "monkoose/matchparen.nvim",
    config = function()
      require("matchparen").setup()
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
