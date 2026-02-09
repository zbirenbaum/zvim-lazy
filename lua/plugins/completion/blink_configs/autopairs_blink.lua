local present, npairs = pcall(require, "nvim-autopairs")
if not present then return end

npairs.setup()

-- blink.cmp has built-in auto_brackets support which handles
-- function/method bracket insertion via semantic tokens.
-- nvim-autopairs is still used for general pair matching (quotes, parens, etc.)
-- but the cmp confirm_done event hook is no longer needed since
-- blink handles bracket completion natively.
