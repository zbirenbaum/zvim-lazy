local colors = require("colors.scheme")
local hl = vim.api.nvim_set_hl

local M = {}

M.apply_colors_highlight = function()
  local black = colors.black
  local black2 = colors.black2
  local blue = colors.blue
  local darker_black = colors.darker_black
  local folder_bg = colors.folder_bg
  local green = colors.green
  local grey = colors.grey
  local grey_fg = colors.grey_fg
  local light_grey = colors.light_grey
  local line = colors.line
  local nord_blue = colors.nord_blue
  local one_bg = colors.one_bg
  local one_bg2 = colors.one_bg2
  local pmenu_bg = colors.pmenu_bg
  local purple = colors.purple
  local red = colors.red
  local white = colors.white
  local yellow = colors.yellow
  local orange = colors.orange
  local sun = colors.sun
  local dark_purple = colors.dark_purple
  local one_bg3 = colors.one_bg3

  -- vim.api.nvim_set_hl(0, "TSVariable", { fg = colors.white })
  -- fg("TSContant", orange, bold=true)
  -- vim.api.nvim_set_hl(0, "TSParameter", {fg=orange, italic=true, bold=true})
  -- vim.api.nvim_set_hl(0, "TSRepeat", {fg=sun, bold=true})
  -- fg("TSKeyword", dark_purple)

  hl(0, "@variable", { fg = colors.white })
  hl(0, "@constant", {fg=orange})
  hl(0, "@parameter", {fg=orange, italic=true, bold=true})
  hl(0, "@repeat", {fg=sun, bold=true})
  hl(0, "@keyword", {fg=dark_purple})
  -- fg("TSKeywordFunction", blue, bold=true)
  -- fg("TSConditional", purple, bold=true)

  -- Comments
  hl(0, "TSComment", { fg = grey_fg, italic = true, bold = true })
  hl(0, "Comment", { fg = grey_fg, italic = true, bold = true })

  -- Disable cursor line
  -- cmd("hi clear CursorLine")
  -- Line number
  hl(0, "CursorLine", {bg=black})
  -- hl(0, "cursorlinenr", {fg=white})
  hl(0, "CursorLineNR", {fg=dark_purple, italic=false, bold=true})

  -- same it bg, so it doesn't appear
  hl(0, "EndOfBuffer", {fg=black})

  -- For floating windows
  hl(0, "FloatBorder", {fg=grey}) --changed bc bright blue hurts my eyes after a while
  hl(0, "NormalFloat", {bg=darker_black})

  -- hl(0, "LspSignatureActiveParameter", {fg=red})

  -- misc

  -- inactive statuslines as thin lines
  hl(0, "StatusLineNC", {fg=one_bg3, underline=true})
  hl(0, "LineNr", {fg=grey})
  hl(0, "NvimInternalError", {fg=red})
  hl(0, "VertSplit", {fg=one_bg2})
  hl(0, "Folded", {bg="NONE"})
  hl(0, "Folded", {fg="NONE"})
  hl(0, "Comment", {fg=grey})
  hl(0, "Normal", {fg=white, bg="NONE"}) --due to api replacing undefineds, needs to be set

  -- Git signs
  hl(0, "DiffAdd", {fg=blue, bg="NONE"})
  hl(0, "DiffChange", {fg=grey_fg, bg="NONE"})
  hl(0, "DiffChangeDelete", {fg=red, bg="NONE"})
  hl(0, "DiffModified", {fg=red, bg="NONE"})
  hl(0, "DiffDelete", {fg=red, bg="NONE"})
  hl(0, "SignColumn", {fg='NONE', bg='NONE'})

  -- Indent blankline plugin
  hl(0, "IndentBlanklineChar", {fg=line})
  hl(0, "IndentBlanklineSpaceChar", {fg=line})

  -- Lsp diagnostics

  hl(0, "DiagnosticHint", {fg=purple})
  hl(0, "DiagnosticError", {fg=red})
  hl(0, "DiagnosticWarn", {fg=yellow})
  hl(0, "DiagnosticInformation", {fg=green})

  -- Telescope
  -- hl(0, "TelescopeBorder", {fg=darker_black, bg=darker_black})
  -- hl(0, "TelescopePromptBorder", {fg=black2, bg=black2})
  --
  -- hl(0, "TelescopePromptNormal", {fg=white, bg=black2})
  -- hl(0, "TelescopePromptPrefix", {fg=red, bg=black2})
  --
  -- hl(0, "TelescopeNormal", {bg=darker_black})
  --
  -- hl(0, "TelescopePreviewTitle", {fg=black, bg=green})
  -- hl(0, "TelescopePromptTitle", {fg=black, bg=red})
  -- hl(0, "TelescopeResultsTitle", {fg=darker_black, bg=darker_black})
  --
  -- hl(0, "TelescopeSelection", {bg=black2})

  -- Disable some highlight in nvim tree if transparency enabled
  hl(0, "NormalFloat", {bg="NONE"})
  hl(0, "TelescopeBorder", {bg="NONE"})
  hl(0, "TelescopePrompt", {bg="NONE"})
  hl(0, "TelescopeResults", {bg="NONE"})
  hl(0, "TelescopePromptBorder", {bg="NONE"})
  hl(0, "TelescopePromptNormal", {bg="NONE"})
  hl(0, "TelescopeNormal", {bg="NONE"})
  hl(0, "TelescopePromptPrefix", {bg="NONE"})
  hl(0, "TelescopeBorder", {fg=one_bg})
  hl(0, "TelescopeResultsTitle", {fg=black, bg=blue})

  hl(0, "TabLineFile",{bg="NONE"})
  hl(0, "TabLine",{bg="#000000"})
  hl(0, 'Pmenu', {bg='#10171f'})
  hl(0, 'PmenuSel', {bg='#263341'})
  hl(0, "PmenuSbar",  {bg=one_bg2})
  hl(0, "PmenuThumb", {bg=nord_blue})

  -- Pmenu
  hl(0, "CmpItemKindText", {fg=white})
  hl(0, "CmpItemKindFunction", { fg = "#C586C0" })
  hl(0, "CmpItemKindClass", { fg = "Orange" })
  hl(0, "CmpItemKindKeyword", { fg = "#f90c71" })
  hl(0, "CmpItemKindSnippet", { fg = "#565c64" })
  hl(0, "CmpItemKindConstructor", { fg = "#ae43f0" })
  hl(0, "CmpItemKindVariable", { fg = "#9CDCFE", bg = "NONE" })
  hl(0, "CmpItemKindInterface", { fg = "#f90c71", bg = "NONE" })
  hl(0, "CmpItemKindFolder", { fg = "#2986cc" })
  hl(0, "CmpItemKindReference", { fg = "#922b21" })
  hl(0, "CmpItemKindMethod", { fg = "#C586C0" })
  hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
  hl(0, "CmpItemAbbr", { fg = "#565c64", bg = "NONE" })
  hl(0, "CmpItemAbbrMatch", { fg = "#569CD6", bg = "NONE" })
  hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#569CD6", bg = "NONE" })
  hl(0, "CmpMenuBorder", { fg="#263341" })
  hl(0, "CmpMenu", { bg="#10171f" })
  hl(0, "CmpSelection", { bg="#263341" })
  hl(0, "WinSeparator", { fg = "#263341" })
end

return M
