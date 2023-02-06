local lspsignature = require("lsp_signature")
lspsignature.setup({
  bind = true,
  doc_lines = 0,
  floating_window = true,
  fix_pos = true,
  hint_enable = false,
  --  hint_prefix = " ",
  --  hint_scheme = "String",
  hi_parameter = "LspSignatureActiveParameter",
  --  virt_text_pos = "eol",
  max_height = 22,
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "single", -- double, single, shadow, none
  },
  zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
  padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
})
