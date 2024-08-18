local k = function ()
  vim.api.nvim_input("<esc>")
  local current_line = vim.api.nvim_get_current_line()
  if current_line:match("^%s+j$") then
    vim.schedule(function()
      vim.api.nvim_set_current_line("")
    end)
  end
end

require("better_escape").setup({
  timeout = 300,
  default_mappings = true,
  mappings = {
    i = {
      j = { k = k, },
    },
    c = {
      j = { k = k, },
    },
    t = {
      j = { k = k, },
    },
    v = {
      j = { k = k, },
    },
    s = {
      j = { k = k, },
    },
  }
})


