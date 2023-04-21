local types = require("cmp.types")
local compare = {}

W = {
  TypeParameter = 1,
  Method = 2,
  Variable = 3,
  Function = 4,
  Constructor = 5,
  Field = 6,
  Class = 6,
  Interface = 8,
  Module = 9,
  Property = 10,
  Unit = 11,
  Value = 12,
  Enum = 13,
  Keyword = 14,
  Snippet = 15,
  Color = 16,
  File = 17,
  Reference = 18,
  Folder = 19,
  EnumMember = 20,
  Constant = 21,
  Struct = 22,
  Event = 23,
  Operator = 24,
  Text = 1,
}
--
compare.disable_snip = function(entry1, entry2)
  local kind1 = entry1:get_kind()
  local kind2 = entry2:get_kind()
  if kind1 ~= kind2 then
    if kind1 == types.lsp.CompletionItemKind.Snippet then
      return false
    end
    if kind2 == types.lsp.CompletionItemKind.Snippet then
      return true
    end
  end
end

compare.disable_text = function(entry1, entry2)
  -- local kind1 = entry1:get_kind()
  -- local kind2 = entry2:get_kind()
  local kind1 = W.kind1
  local kind2 = W.kind1
  if kind1 ~= kind2 then
    if kind1 == types.lsp.CompletionItemKind.Text then
      return false
    end
    if kind2 == types.lsp.CompletionItemKind.Text then
      return true
    end
  end
end

compare.kind_sort = function(entry1, entry2)
  local kind1 = entry1:get_kind()
  print(kind1)
  --kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
  local kind2 = entry2:get_kind()
  --kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
  if kind1 ~= kind2 then
    -- if kind1 == types.lsp.CompletionItemKind.Snippet then
    --   return false
    -- end
    -- if kind2 == types.lsp.CompletionItemKind.Snippet then
    --   return true
    -- end
    local diff = kind1 - kind2
    if diff < 0 then
      return true
    elseif diff > 0 then
      return false
    end
  end
end

return compare
