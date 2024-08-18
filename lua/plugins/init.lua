local plugins = {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function ()
      require('colors.tokyonight').setup()
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },
  {
    'willothy/flatten.nvim',
    opts = require('plugins.other.flatten'),
    cond = function ()
      return not os.getenv('NVIM') ~= nil
    end,
    lazy = false,
    priority = 1001,
  },
  { 'lewis6991/impatient.nvim'},
  {
    'kevinhwang91/nvim-ufo',
    event = 'LspAttach',
    dependencies ='kevinhwang91/promise-async',
    enabled = false
  },
  {
    'nvim-tree/nvim-tree.lua',
    keys = { '<leader>n' },
    config = function ()
      require('plugins.other.nvim_tree')
    end
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'pyright', 'bashls' }
      })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false,
    -- commit="3f0e8b42f30138e0d1534862bfb3e984f4401d06",
    config = function ()
      vim.g.rustaceanvim = function()
        -- Update this path
        local mason_path = vim.fn.stdpath('data') .. '/mason'
        local ext_path = mason_path .. '/packages/codelldb/extension'
        -- local bin = mason_path .. '/bin/codelldb'

        -- Update this path
        local codelldb_path = ext_path .. '/adapter/codelldb'
        local liblldb_path = ext_path .. '/lldb/lib/liblldb.so'
        local this_os = vim.uv.os_uname().sysname;
        -- The liblldb extension is .so for Linux and .dylib for MacOS
        liblldb_path = liblldb_path .. (this_os == 'Linux' and '.so' or '.dylib')
        local cfg = require('rustaceanvim.config')
        return {
          server = {
            default_settings = {
              ['rust-analyzer'] = {
                files = { watcher =  "client" },
                -- cargo = {
                --   buildScripts = {
                --     enable = false,
                --     invocation_strategy = 'once',
                --   },
                -- },
                procMacro = { enable = true, }
              }
            }
          },
          dap = {
            adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
            load_rust_types = false,
          },
        }
      end
    end,
    ft = "rust",
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = {'Telescope'},
    keys = { '<leader>ff', '<leader>fg', '<leader>fG' },
    config = function()
      require('plugins.other.telescope')
    end,
  },
  {'nvim-telescope/telescope-fzy-native.nvim'},
  {
    'ggandor/flit.nvim',
    -- disable = false,
    keys = function ()
      return vim.tbl_map(function(key)
        return { key, mode = { 'n', 'v', 'x', 'o' } }
      end, { 'f', 'F', 't', 'T' })
    end,
    config = function()
      require('flit').setup({
        multiline = true,
        labeled_modes = 'nv'
      })
    end,
  },
  {
    'ggandor/leap.nvim',
    keys = function ()
      return vim.tbl_map(function(key)
        return { key, mode = { 'n', 'v', 'x', 'o' } }
      end, {'x', 's', 'X', 'S'})
    end,
    commit='9857f64c869f83e36bcde036213c758fc435d9b2',
    config = function()
      require('plugins.other.leap')
    end,
    dependencies = { 'tpope/vim-repeat', },
  },
  {'tpope/vim-repeat'},
  -- LSP and Completion
  {
    'jose-elias-alvarez/typescript.nvim',
    lazy = true,
  },
  {
    'neovim/nvim-lspconfig',
    event = {'VimEnter'},
    config = function()
      require('plugins.lsp.lsp_init').setup_lsp()
    end,
    dependencies = {
      'folke/neodev.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'zbirenbaum/copilot.lua',
    }
  },
  {
    'L3MON4D3/LuaSnip',
    lazy = true,
    config = function()
      local luasnip = require('luasnip')
      luasnip.config.set_config({
        defaults = {
          history = true,
          updateevents = 'TextChanged,TextChangedI',
        },
      })
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    branch = 'enterprise-auth',
    enabled = false,
    config = function()
      require('copilot').setup({
        connection = {
          copilot_auth_provider_url = "fake.com",
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<M-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
      })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function ()
      require('copilot_cmp').setup()
    end,
    enabled = false,
  },
  -- {
  --   'zbirenbaum/neodim',
  --   event = {'LspAttach'},
  --   config = function ()
  --     require('neodim').setup()
  --   end
  -- },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CursorHold' },
    config = function()
      require('plugins.completion.cmp_configs.cmp')
    end,
    dependencies = {
      'folke/neodev.nvim',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
  },
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('plugins.completion.cmp_configs.lspsignature_cmp')
    end,
  },
  {
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup({
        library = {
          -- plugins = { 'nvim-dap-ui' }, types = true
          plugins = false
        }
      })
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = {'Trouble', 'TroubleToggle', 'TroubleRefresh', 'TroubleClose'},
    lazy = true,
    config = function()
      require('plugins.other.trouble')
    end,
  },
  {
    'kylechui/nvim-surround',
    config = function ()
      require('nvim-surround').setup()
    end,
  },
  {
      'altermo/ultimate-autopair.nvim',
      event={'InsertEnter','CmdlineEnter'},
      branch='v0.6', --recommended as each new version will have breaking changes
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.completion.autopairs')
    end,
    enabled = false,
  },
  {
    'NvChad/nvterm',
    keys = {'<C-l>', '<A-h>', '<A-v>', '<A-i>'},
    config = function ()
      require('nvterm').setup()
      require('utils.mappings').terminal()
    end
  },
  {
    'max397574/better-escape.nvim',
    event = 'InsertCharPre',
    config = function()
      require('plugins.other.better_escape')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('plugins.other.treesitter')
    end,
    dependencies = {'nvim-treesitter/playground'},
  },
  {
    'numToStr/Comment.nvim',
    keys = { 'gcc', '<leader>/' },
    lazy = false,
    config = function()
      require('utils.mappings').comment()
      require('Comment').setup()
    end,
  },
  {
    'nvim-neorg/neorg',
    ft = 'norg',
    build = ':Neorg sync-parsers',
    enabled = false,
    config = function()
      require('plugins.other.neorg')
    end,
    dependencies={'kyazdani42/nvim-web-devicons', 'nvim-lua/plenary.nvim'}
  },
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  {
    'kyazdani42/nvim-web-devicons',
    lazy = true,
    config = function()
      require('plugins.other.icons').setup()
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    commit = '9637670896b68805430e2f72cf5d16be5b97a22a',
    -- main = 'ibl',
    config = function()
      require('plugins.other.indent_blankline')
    end,
  },
  {
    'feline-nvim/feline.nvim',
    event = 'VeryLazy',
    config = function()
      require('plugins.other.feline')
    end,
  },
  {
    'gennaro-tedesco/nvim-jqx',
    cmd = {'JqxList', 'JqxQuery'},
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.other.gitsigns')
    end,
  },
  -- {
  --   'monkoose/matchparen.nvim',
  --   config = function()
  --     require('matchparen').setup({})
  --   end,
  -- },
  -- {
  --   'zbirenbaum/nvim-base16.lua',
  --   config = function()
  --     require('colors').init('onedark')
  --   end,
  -- },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    keys = {
      '<Leader>b',
      '<C-o>',
      '<C-O>',
      '<C-n>',
      '<Leader>r',
      '<Leader>c',
    },
    config = function ()
      require('plugins.dap.dap_setup').config()
      require('utils.mappings').debug()
    end,
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      'mrcjkb/rustaceanvim',
      -- 'rcarriga/nvim-dap-ui',
    }
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    config = function ()
      require('plugins.dap.vtext')
    end
  },

  {
    'rcarriga/nvim-dap-ui',
    lazy=true,
    enabled = false,
    config = function()
      require('dapui').setup()
      require('plugins.dap.dap_setup').config_dapui()
    end
  },
  { 'jbyuki/one-small-step-for-vimkind', lazy = true },
  { 'mxsdev/nvim-dap-vscode-js', lazy = true },
  { 'nvim-neotest/nvim-nio', lazy = true }
}

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local bufnr = args.buf
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client and client.supports_method("textDocument/completion") then
--       vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
--     end
--   end
-- })

return plugins
