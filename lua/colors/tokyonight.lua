local overrides = {
  ["DiffAdd"] = { fg = '#61afef', bg = 'NONE' },
  ["DiffChange"] = { fg = '#565c64', bg = 'NONE' },
  ["DiffChangeDelete"] = { fg = '#d47d85', bg = 'NONE' },
  ["DiffModified"] = { fg = '#d47d85', bg = 'NONE' },
  ["DiffDelete"] = { fg = '#d47d85', bg = 'NONE' },
  ["SignColumn"] = { fg = 'NONE', bg = 'NONE' },
  -- ["CmpItemKindText"] = {fg=white},
  ["CmpItemKindFunction"] = { fg = "#C586C0" },
  ["CmpItemKindClass"] = { fg = "Orange" },
  ["CmpItemKindKeyword"] = { fg = "#f90c71" },
  ["CmpItemKindSnippet"] = { fg = "#565c64" },
  ["CmpItemKindConstructor"] = { fg = "#ae43f0" },
  ["CmpItemKindVariable"] = { fg = "#9CDCFE", bg = "NONE" },
  ["CmpItemKindInterface"] = { fg = "#f90c71", bg = "NONE" },
  ["CmpItemKindFolder"] = { fg = "#2986cc" },
  ["CmpItemKindReference"] = { fg = "#922b21" },
  ["CmpItemKindMethod"] = { fg = "#C586C0" },
  ["CmpItemKindCopilot"] = { fg = "#6CC644" },
  ["CmpItemAbbr"] = { fg = "#565c64", bg = "NONE" },
  ["CmpItemAbbrMatch"] = { fg = "#569CD6", bg = "NONE" },
  ["CmpItemAbbrMatchFuzzy"] = { fg = "#569CD6", bg = "NONE" },
  ["CmpMenuBorder"] = { fg="#263341" },
  ["CmpMenu"] = { bg="#10171f" },
  ["CmpSelection"] = { bg="#263341" },
}

local setup = function ()
  require('tokyonight').setup({
    style = 'night',
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
    },
    on_highlights = function (hl, _)
      for group, highlight in pairs(overrides) do
        hl[group] = highlight
      end
    end
  })

  -- Pmenu
  vim.cmd[[colorscheme tokyonight]]
end

return { setup = setup }
