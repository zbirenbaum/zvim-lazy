local present, blink = pcall(require, "blink.cmp")
if not present then return end
local symbols = require("plugins.completion.blink_configs.symbols")

blink.setup({
  -- keymap = {
    -- preset = 'none',
    -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    -- ['<C-e>'] = { 'hide', 'fallback' },
    -- ['<C-y>'] = { 'accept', 'fallback' },
    --
    -- ['<C-p>'] = { 'select_prev', 'fallback' },
    -- ['<C-n>'] = { 'select_next', 'fallback' },
    --
    -- ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
    -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    --
    -- ['<PageUp>'] = { function(cmp) return cmp.select_prev({ count = 10 }) end, 'fallback' },
    -- ['<PageDown>'] = { function(cmp) return cmp.select_next({ count = 10 }) end, 'fallback' },

    -- ['<Tab>'] = {
    --   function(cmp)
    --     if cmp.is_visible() then
    --       return cmp.select_next()
    --     end
    --   end,
    --   'fallback',
    -- },
    -- ['<S-Tab>'] = {
    --   function(cmp)
    --     if cmp.is_visible() then
    --       return cmp.select_prev()
    --     end
    --   end,
    --   'fallback',
    -- },
    -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  -- },

  appearance = {
    nerd_font_variant = 'mono',
    kind_icons = symbols,
  },

  completion = {
    list = {
      max_items = 12,
      selection = { preselect = true, auto_insert = true },
    },

    accept = {
      auto_brackets = { enabled = true },
    },

    menu = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = 'Normal:CmpMenu,FloatBorder:CmpMenuBorder,CursorLine:CmpSelection,Search:None',
      draw = {
        columns = {
          { 'kind_icon' },
          { 'label', gap = 1 },
          { 'kind' },
        },
        components = {
          kind_icon = {
            text = function(ctx) return '[' .. ctx.kind_icon .. ']' .. ctx.icon_gap end,
            highlight = function(ctx) return { { group = ctx.kind_hl, priority = 20000 } } end,
          },
          label = {
            width = { max = 50 },
          },
        },
      },
    },

    documentation = {
      auto_show = true,
      -- auto_show_delay_ms = 200,
      window = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
      },
    },

    ghost_text = { enabled = true },
  },

  signature = { enabled = true },

  snippets = { preset = 'luasnip' },

  fuzzy = {
    implementation = "prefer_rust",
    sorts = {
      'exact',
      'score',
      'sort_text',
    },
  },

  sources = {
    transform_items = function(ctx, items)
      -- Remove the "Text" source from lsp autocomplete
      return vim.tbl_filter(function(item)
        return item.kind ~= vim.lsp.protocol.CompletionItemKind.Text
      end, items)
    end,
    -- default = { 'lsp', 'path', 'snippets' },
  },
})
