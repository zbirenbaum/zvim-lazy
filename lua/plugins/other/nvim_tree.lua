require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<cr>')
