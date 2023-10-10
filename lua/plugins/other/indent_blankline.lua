local colors = require("colors").get()
require("indent_blankline").setup({
  filetype_exclude = {
    "help",
    "terminal",
    "dashboard",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "nvchad_cheatsheet",
    "lsp-installer",
    "",
  },
  show_end_of_line = true,
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
  vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { nocombine = true, fg = colors.grey_fg }),
  vim.api.nvim_set_hl(
    0,
    "IndentBlanklineContextStart",
    { nocombine = false, underline = true, special = colors.grey_fg }
  ),
})
vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')

-- highlight IndentBlanklineContextChar guifg=#00FF00 gui=nocombine
-- highlight IndentBlanklineContextStart guisp=#00FF00 gui=underline

-- local hooks = require('ibl.hooks')
-- local colors = require("colors").get()

-- vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { nocombine = true, underline = true, fg = colors.white})
-- require("ibl").setup({
--   exclude = {
--     filetypes = {
--       "help",
--       "terminal",
--       "dashboard",
--       "packer",
--       "lspinfo",
--       "TelescopePrompt",
--       "TelescopeResults",
--       "lsp-installer",
--       "",
--     }
--   },
--   indent = {
--     char = "│"
--   },
--   scope = {
--     highlight = "IndentBlanklineContextChar",
--     enabled = true,
--     show_start = true,
--     show_end = true,
--     include = { node_type = {
--       ['*'] = {"punctuation", "constructor", "conditional"} } },
--     priority = 1000,
--   }
-- })
-- hooks.register(
--   hooks.type.WHITESPACE,
--   hooks.builtin.hide_first_space_indent_level
-- )
--
-- vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')

  -- show_end_of_line = true,
  -- show_trailing_blankline_indent = false,
  -- show_first_indent_level = false,
  -- show_current_context = true,
  -- show_current_context_start = true,
  -- vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { nocombine = true, fg = colors.grey_fg }),
  -- vim.api.nvim_set_hl(
  --   0,
  --   "IndentBlanklineContextStart",
  --   { nocombine = false, underline = true, special = colors.grey_fg }
  -- ),
-- highlight IndentBlanklineContextChar guifg=#00FF00 gui=nocombine
-- highlight IndentBlanklineContextStart guisp=#00FF00 gui=underline
