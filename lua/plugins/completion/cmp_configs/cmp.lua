local present, cmp = pcall(require, "cmp")

if not present then return end

local luasnip = require("luasnip")
-- local lspkind = require("plugins.completion.cmp_configs.lspkind")
local symbols = require("plugins.completion.cmp_configs.symbols")

local has_copilot, copilot_cmp = pcall(require, "copilot_cmp.comparators")

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

vim.opt.completeopt = "menuone,noselect"
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  style = {
    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
  },
  formatting = {
    fields = {"kind", "abbr", "menu"},
    format = function(entry, vim_item)
      vim_item.menu_hl_group = "CmpItemKind" .. vim_item.kind
      vim_item.menu = vim_item.kind
      vim_item.abbr = vim_item.abbr:sub(1, 50)
      vim_item.kind = '[' .. symbols[vim_item.kind] .. ']'
      return vim_item
    end
  },
  window = {
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      scrollbar = "║",
      winhighlight = 'Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpSelection,Search:None',
      autocomplete = {
        require("cmp.types").cmp.TriggerEvent.InsertEnter,
        require("cmp.types").cmp.TriggerEvent.TextChanged,
      },
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      scrollbar = "║",
    },
  },
  mapping = {
    ["<PageUp>"] = function()
      for _ = 1, 10 do
        cmp.mapping.select_prev_item()(nil)
      end
    end,
    ["<PageDown>"] = function()
      for _ = 1, 10 do
        cmp.mapping.select_next_item()(nil)
      end
    end,
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-s>"] = cmp.mapping.complete({
        config = {
          sources = {
            { name = 'copilot' },
          }
        }
      }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      -- select = false,
    }),
    ["<Tab>"] = function (fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  sources = {
    { name = "copilot", group_index = 1 },
    { name = "nvim_lsp", group_index = 1 },
    { name = "path", group_index = 1 },
    { name = 'neorg', group_index = 2 },

    -- keep disabled
    -- { name = 'orgmode', group_index = 2 },
    -- { name = "nvim_lua", group_index = 2 },
    -- { name = "luasnip", group_index = 2 },
    -- { name = "buffer", group_index = 5 },
  },
  sorting = {
    --keep priority weight at 2 for much closer matches to appear above copilot
    --set to 1 to make copilot always appear on top
    priority_weight = 1,
    comparators = {
      -- order matters here
      cmp.config.compare.exact,
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      has_copilot and copilot_cmp.prioritize or nil,
      has_copilot and copilot_cmp.score or nil,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
      -- personal settings:
      -- cmp.config.compare.recently_used,
      -- cmp.config.compare.offset,
      -- cmp.config.compare.score,
      -- cmp.config.compare.sort_text,
      -- cmp.config.compare.length,
      -- cmp.config.compare.order,
    },
  },
  preselect = cmp.PreselectMode.Item,
})

--set max height of items
vim.cmd([[ set pumheight=6 ]])
--set highlights
