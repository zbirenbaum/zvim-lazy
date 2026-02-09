local sig_cfg = {
  bind = true,
  hint_enable = true,
  hint_prefix = '',
  floating_window = false,
  transparency = 100,
  doc_lines=0,
  always_trigger = true,
  fix_pos = false,
  extra_trigger_chars = {'(', ',', ')'},
  hi_parameter = "LspSignatureActiveParameter",
  handler_opts = {
    border = "none",
  },
  floating_window_off_x = 2,
  floating_window_off_y = 0,
}

local setup = function (bufnr)
  require("lsp_signature").on_attach(sig_cfg, bufnr)
end

return { setup = setup }
