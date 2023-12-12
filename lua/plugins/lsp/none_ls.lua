local M = {}

M.filetypes = {
  "css",
  "graphql",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "less",
  "markdown",
  "scss",
  "typescript",
  "typescriptreact",
  "yaml",
}


M.setupNLS = function ()
  local null_ls = require("null-ls")
  local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
  local event = "BufWritePre" -- or "BufWritePost"
  local async = event == "BufWritePost"

  null_ls.setup({
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.keymap.set("n", "<Leader>f", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })

        -- format on save
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd(event, {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, async = async })
          end,
          desc = "[lsp] format on save",
        })
      end

      if client.supports_method("textDocument/rangeFormatting") then
        vim.keymap.set("x", "<Leader>f", function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = "[lsp] format" })
      end
    end,
  })
end

M.setupESLint = function ()
  local eslint = require('eslint')
  eslint.setup({
    bin = 'eslint_d',
    code_actions = {
      enable = true,
      apply_on_save = {
        enable = true,
        types = { 'directive', 'problem', 'suggestion', 'layout' },
      },
      disable_rule_comment = {
        enable = true,
        location = 'separate_line', -- or `same_line`
      },
    },
    diagnostics = {
      enable = true,
      report_unused_disable_directives = false,
      run_on = 'type', -- or `save`
    },
  })
end

M.setupPrettier = function ()
  local prettier = require("prettier")
  prettier.setup({
    bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
    filetypes = {
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "less",
      "markdown",
      "scss",
      "typescript",
      "typescriptreact",
      "yaml",
    },
  })
end

return M
