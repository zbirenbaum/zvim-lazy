local a = vim.api
local colors = require("colors").get()
local lsp = require("feline.providers.lsp")
local ct = {}

local test_width = function (winid)
  local comp = vim.o.laststatus == 3 and vim.o.columns or a.nvim_win_get_width(tonumber(winid) or 0)
  return comp >= 70
end

local statusline_style = {
  left = "",
  right = "",
  main_icon = "  ",
  vi_mode_icon = " ⚡",
  position_icon = " ",
}

local sep_spaces = {
  left = " ",
  right = "",
}
local empty = "NONE"

local mode_colors = {
  ["n"] = { "NORMAL", colors.red },
  ["no"] = { "N-PENDING", colors.red },
  ["i"] = { "INSERT", colors.dark_purple },
  ["ic"] = { "INSERT", colors.dark_purple },
  ["t"] = { "TERMINAL", colors.green },
  ["v"] = { "VISUAL", colors.cyan },
  ["V"] = { "V-LINE", colors.cyan },
  [""] = { "V-BLOCK", colors.cyan },
  ["R"] = { "REPLACE", colors.orange },
  ["Rv"] = { "V-REPLACE", colors.orange },
  ["s"] = { "SELECT", colors.nord_blue },
  ["S"] = { "S-LINE", colors.nord_blue },
  [""] = { "S-BLOCK", colors.nord_blue },
  ["c"] = { "COMMAND", colors.pink },
  ["cv"] = { "COMMAND", colors.pink },
  ["ce"] = { "COMMAND", colors.pink },
  ["r"] = { "PROMPT", colors.teal },
  ["rm"] = { "MORE", colors.teal },
  ["r?"] = { "CONFIRM", colors.teal },
  ["!"] = { "SHELL", colors.green },
}

local chad_mode_hl = function()
  return { fg = mode_colors[vim.fn.mode()][2], bg = empty, }
end

ct.space = function(cond)
  return {
    provider = " ",
    enabled = cond,
    hl = { bg = empty, fg = colors.empty },
  }
end

ct.main_icon = {
  provider = statusline_style.main_icon,
  hl = { fg = empty, bg = colors.nord_blue, },
  left_sep = {
    str = statusline_style.right,
    hl = { fg = colors.nord_blue, bg = colors.lightbg, },
  },
}


ct.file = {
  provider = function()
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    local icon = require("nvim-web-devicons").get_icon(filename, extension)
    if filename == nil or filename == "" or filename == " " then
      return ""
    end
    if icon == nil then
      return " " .. filename .. " "
    end
    return " " .. icon .. " " .. filename .. " "
  end,
  enabled = test_width,
  hl = function () return {
    fg = vim.bo.modified and '#cab873' or colors.white,
    bg = colors.lightbg,
  } end,
  left_sep = {
    str = sep_spaces.left,
    hl = {
      fg = colors.lightbg,
      bg = empty,
    },
  },
  right_sep = {
    str = " ",
    hl = {
      fg = colors.lightbg,
      bg = empty,
    },
  },
}

ct.dir = {
  provider = function()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return "  " .. dir_name .. " "
  end,

  enabled = test_width,
  hl = {
    fg = colors.cyan,
    bg = colors.lightbg,
  },
  left_sep = {
    str = " " .. statusline_style.left,
    hl = {
      fg = colors.lightbg,
      bg = empty,
    },
  },
  right_sep = {
    str = sep_spaces.right,
    hl = {
      fg = colors.lightbg,
      bg = empty,
    },
  },
}

ct.git = {
  added = {
    provider = "git_diff_added",
    hl = {
      fg = colors.green,
      bg = empty,
    },
    --icon = "  ",
    icon = "  ",
  },
  changed = {
    provider = "git_diff_changed",
    hl = {
      fg = colors.orange,
      bg = empty,
    },
    icon = "  ",
  },
  removed = {
    provider = "git_diff_removed",
    hl = {
      fg = colors.red,
      bg = empty,
    },
    --icon = "  ",
    icon = "  ",
  },

  branch = {
    provider = "git_branch",
    enabled = function(winid)
      local path = vim.fn.expand("%:p")
      local cwd = vim.fn.getcwd()
      local gitrepo = false
      if path:find(cwd) ~= nil then
        gitrepo = true
      end
      return gitrepo and a.nvim_win_get_width(tonumber(winid) or 0) > 70
    end,
    hl = {
      fg = colors.nord_blue,
      bg = empty,
    },
    icon = {
      str = "  ",
      hl = {
        fg = colors.green,
        bg = empty,
      },
    },
  },
  branch_bg = {
    provider = "git_branch",
    enabled = function(winid)
      local path = vim.fn.expand("%:p")
      local cwd = vim.fn.getcwd()
      local gitrepo = false
      if path:find(cwd) ~= nil then
        gitrepo = true
      end
      return gitrepo and a.nvim_win_get_width(tonumber(winid) or 0) > 70
    end,
    hl = {
      fg = colors.nord_blue,
      bg = colors.lightbg,
    },
    icon = {
      str = "  ",
      hl = {
        fg = colors.green,
        bg = colors.lightbg,
      },
    },
    left_sep = {
      str = " " .. statusline_style.left,
      hl = {
        fg = colors.lightbg,
        bg = empty,
      },
    },
  },
  git_sep = {
    provider = " ",
    enabled = function(winid)
      local path = vim.fn.expand("%:p")
      local cwd = vim.fn.getcwd()
      local gitrepo = false
      if path:find(cwd) ~= nil then
        gitrepo = true
      end
      return gitrepo and a.nvim_win_get_width(tonumber(winid) or 0) > 70
    end,
    hl = {
      bg = colors.lightbg,
      fg = empty,
    },
    right_sep = {
      str = statusline_style.right,
      hl = {
        fg = colors.lightbg,
        bg = empty,
      },
    },
  },
}

ct.diagnostics = {
  errors = {
    provider = "diagnostic_errors",
    enabled = function()
      return lsp.diagnostics_exist("ERROR")
    end,

    hl = { bg = empty, fg = colors.red },
    icon = "  ",
  },
  warnings = {
    provider = "diagnostic_warnings",
    enabled = function()
      return lsp.diagnostics_exist("WARN")
    end,
    hl = { bg = empty, fg = colors.yellow },
    icon = "  ",
  },
  hints = {
    provider = "diagnostic_hints",
    enabled = function()
      return lsp.diagnostics_exist("HINT")
    end,
    hl = { bg = empty, fg = colors.grey_fg2 },
    icon = "  ",
  },
  info = {
    provider = "diagnostic_info",
    enabled = function()
      return lsp.diagnostics_exist("INFO")
    end,
    hl = { bg = empty, fg = colors.green },
    icon = "  ",
  },

  spacer = {
    provider = "  ",
    hl = { bg = empty, fg = colors.empty },
  },
}

ct.progress = {
  provider = function()
    local client = vim.lsp.get_active_clients({buf = a.nvim_get_current_buf()})
    local Lsp = vim.lsp.util.get_progress_messages()[1]
    if Lsp and client and client[1].name ~= "ccls" then
      local msg = Lsp.message or ""
      local percentage = Lsp.percentage or 0
      local title = Lsp.title or ""
      local spinners = {
        "",
        "",
        "",
      }

      local success_icon = {
        "",
        "",
        "",
      }

      local ms = vim.loop.hrtime() / 1000000
      local frame = math.floor(ms / 120) % #spinners

      if percentage >= 70 then
        return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
      end

      return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
    end

    return ""
  end,
  enabled = function(winid)
    return a.nvim_win_get_width(tonumber(winid) or 0) > 80
  end,
  hl = { fg = colors.green, bg = empty },
}

ct.lsp = {
  provider = function()
    local icons = require("plugins.lsp.lsp_configs.langserver_icons")
    local names = vim.tbl_map(function (client)
      return icons and icons[client.name] or client.name
    end, vim.lsp.get_active_clients({buf = a.nvim_get_current_buf()}))
    return table.concat(names, "")
    -- return "  " .. table.concat(names, '')
  end,
  enabled = test_width,
  hl = { fg = colors.nord_blue, bg = empty },
}

ct.mode = {
  left_sep = {
    provider = statusline_style.left,
    hl = function()
      return {
        fg = colors.lightbg,
        bg = empty,
      }
    end,
  },
  right_sep = {
    provider = statusline_style.right,
    hl = function()
      return {
        fg = colors.lightbg,
        bg = empty,
      }
    end,
  },
  mode_icon = {
    provider = statusline_style.vi_mode_icon,
    hl = function()
      return {
        bg = empty, --colors.lightbg,
        fg = mode_colors[vim.fn.mode()][2],
      }
    end,
  },
  mode_string = {
    provider = function()
      return " " .. mode_colors[vim.fn.mode()][1] .. ""
    end,
    hl = chad_mode_hl,
  },
}

ct.location = {
  left_sep = {
    provider = " " .. statusline_style.left,
    enabled = function(winid)
      return a.nvim_win_get_width(tonumber(winid) or 0) > 90
    end,
    hl = {
      fg = colors.green,
      bg = empty,
    },
  },
  loc_icon = {
    provider = "  " .. statusline_style.position_icon,
    enabled = function(winid)
      return a.nvim_win_get_width(tonumber(winid) or 0) > 90
    end,
    hl = {
      fg = colors.green,
      bg = empty,
    },
  },
  loc_string = {
    provider = function()
      local current_line = vim.fn.line(".")
      local total_line = vim.fn.line("$")

      if current_line == 1 then
        return "Top"
      elseif current_line == vim.fn.line("$") then
        return "Bot"
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return "" .. result .. "%%"
    end,

    enabled = function(winid)
      return a.nvim_win_get_width(tonumber(winid) or 0) > 90
    end,

    hl = {
      fg = colors.green,
      bg = empty,
    },
  },
}


local get_tabs = function ()
  return a.nvim_list_tabpages()
end

local get_left_tabs = function ()
  local current = a.nvim_tabpage_get_number(0)
  if current == 1 then return '' end
  local tabstring = ''
  local i = 1
  while i < current do
    tabstring = tabstring .. tostring(i) .. '|'
    i = i + 1
  end
  return tabstring
end

local get_right_tabs = function ()
  local tab_list = get_tabs()
  local current = a.nvim_tabpage_get_number(0)
  if current == tab_list[#tab_list] then return '' end
  local tabstring = ''
  local i = current + 1
  while i <= #tab_list do
    tabstring =  tabstring .. '|' .. tostring(i)
    i = i + 1
  end
  return tabstring
end

local tabline_cond = function()
  return #get_tabs() > 1
end -- check there is more than 1

ct.tabs = {
  left = {
    provider = ' [',
    enabled = tabline_cond,
    hl = {
      fg = colors.cyan,
      bg = empty,
    },
  },
  right = {
    provider =  ']',
    enabled = tabline_cond,
    hl = {
      fg = colors.cyan,
      bg = empty,
    },
  },
  inactive_left = {
    provider = function ()
      return get_left_tabs()
    end,
    enabled = tabline_cond,
    hl = {
      fg = colors.grey_fg2,
      bg = empty,
    }
  },
  active = {
    provider = function ()
      return tostring(a.nvim_tabpage_get_number(0))
    end,
    enabled = tabline_cond,
    hl = {
      fg = colors.green,
      bg = empty,
      bold = true,
    }
  },
  inactive_right = {
    provider = function ()
      return get_right_tabs()
    end,
    enabled = tabline_cond,
    hl = {
      fg = colors.grey_fg2,
      bg = empty,
    }
  },
}

-- local colors = require("colors").get()

local colors = {
   white = "#abb2bf",
   darker_black = "#1b1f27",
   black = "#1e222a", --  nvim bg
   black2 = "#252931",
   one_bg = "#282c34", -- real bg of onedark
   one_bg2 = "#353b45",
   one_bg3 = "#30343c",
   grey = "#42464e",
   grey_fg = "#565c64",
   grey_fg2 = "#6f737b",
   light_grey = "#6f737b",
   red = "#d47d85",
   baby_pink = "#DE8C92",
   pink = "#ff75a0",
   line = "#2a2e36", -- for lines like vertsplit
   green = "#A3BE8C",
   vibrant_green = "#7eca9c",
   nord_blue = "#81A1C1",
   blue = "#61afef",
   yellow = "#e7c787",
   sun = "#EBCB8B",
   purple = "#b4bbc8",
   dark_purple = "#c882e7",
   teal = "#519ABA",
   orange = "#fca2aa",
   cyan = "#a3b8ef",
   statusline_bg = "#22262e",
   lightbg = "#2d3139",
   lightbg2 = "#262a32",
   pmenu_bg = "#A3BE8C",
   folder_bg = "#61afef",
}

local components = {
  active = {},
  inactive = {},
}

components.active[1] = {  --left
  ct.mode.mode_string,
  ct.dir,
  ct.file,
  ct.lsp,
  ct.diagnostics.errors,
  ct.diagnostics.warnings,
  ct.diagnostics.hints,
  ct.diagnostics.info,
  ct.diagnostics.spacer,
}

components.active[2] = {  -- right
  ct.git.branch,
  ct.git.added,
  ct.git.changed,
  ct.git.removed,
  ct.tabs.left,
  ct.tabs.inactive_left,
  ct.tabs.active,
  ct.tabs.inactive_right,
  ct.tabs.right,
  ct.location.loc_icon,
  ct.location.loc_string,
}

components.inactive[1] = {
  provider = " ",
  hl = {
    fg = colors.one_bg2,
    bg = "NONE",
    style = "underline",
  }
}

require("feline").setup({
  colors = {
    bg = colors.statusline_bg,
    fg = colors.fg,
  },
  components = components,
})
