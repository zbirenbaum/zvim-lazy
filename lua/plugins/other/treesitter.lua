-- require "nvim-treesitter.parsers".get_parser_configs().Solidity = {
--   install_info = {
--     url = "https://github.com/JoranHonig/tree-sitter-solidity",
--     files = {"src/parser.c"},
--     requires_generate_from_grammar = true,
--   },
--   filetype = 'solidity'
-- }
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "rust",
    "go",
    "python",
    "javascript",
    "typescript",
    "bash",
    "gomod",
    "cuda",
    "cmake",
    "comment",
    "json",
    "regex",
    "yaml",
    "solidity",
    "markdown",
  },
  indent = {
    enable = false,
  },
  highlight = {
    enable = true,
  },
})

vim.api.nvim_create_autocmd({'BufNewFile'}, {
  callback=function(args)
    vim.api.nvim_create_autocmd({'InsertEnter'}, {
      pattern = args.name,
      callback = function ()
        vim.cmd('TSBufEnable highlight');
      end,
      once = true
    })
  end,
  once = false,
})
