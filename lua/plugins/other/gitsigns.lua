require("gitsigns").setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = '┆' },
  },
})

vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'DiffAdd' })
vim.api.nvim_set_hl(0, 'GitSignsAddNr', { link = 'GitSignsAddNr' })
vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'DiffChange' })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { link = 'GitSignsChangeNr' })
vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { link = 'GitSignsDeleteNr' })
vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'DiffChangeDelete' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { link = 'GitSignsChangeNr' })
vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'DiffDelete' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { link = 'GitSignsDeleteNr' })
vim.api.nvim_set_hl(0, 'GitSignsUntracked', { link = 'GitSignsAdd' })
vim.api.nvim_set_hl(0, 'GitSignsUntrackedLn', { link = 'GitSignsAddLn' })
vim.api.nvim_set_hl(0, 'GitSignsUntrackedNr', { link = 'GitSignsAddNr' })
vim.api.nvim_set_hl(0, 'GitSignsUntrackedLn', { link = 'GitSignsAddLn' })
vim.api.nvim_set_hl(0, 'GitSignsUntrackedNr', { link = 'GitSignsAddNr' })
