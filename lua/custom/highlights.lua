-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local git_colors = {
  red = "#7d1e20",
  light_red = "#794756",
  dark_red = "#482a33",
  green = "#00ff00",
  dark_green = "#334535",

  dark_blue = "#3d5c7b",
  orange = "#87663b",
  white = "#ffffff",
}


local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
  -- Gitsigns.nvim
  DiffAdd = { fg = "NONE", bg = git_colors.dark_green },
  DiffAdded = { fg = "NONE", bg = git_colors.dark_green },
  DiffChange = { fg = "NONE", bg = git_colors.dark_green },
  DiffChangeDelete = { fg = "NONE", bg = git_colors.dark_red },
  DiffModified = { fg = "NONE", bg = git_colors.dark_blue },
  DiffDelete = { fg = "red", bg = git_colors.dark_red },
  DiffRemoved = { fg = "NONE", bg = git_colors.dark_red },

  IndentBlanklineIndent1 = { fg = "#325a5e" },
  IndentBlanklineIndent2 = { fg = "#325a5e" },
  IndentBlanklineIndent3 = { fg = "#324b7b" },
  IndentBlanklineIndent4 = { fg = "#216631" },
  IndentBlanklineIndent5 = { fg = "#563931" },
  IndentBlanklineIndent6 = { fg = "#662121" },
  IndentBlanklineIndent7 = { fg = "#562155" },

  -- ErrorMsg = { fg = "darker_black", bg = "red" },
  TbLineBufOn = { fg = "#ffffff", bg = "#2f3152" },
  TbLineBufOnClose = { fg = "#ffffff", bg = "#2f3152" },
  TbLineBufOnModified = { bg = "#2f3152" },
  TbLineBufOff = { bg = "#212236" },
  TbLineBufOffClose = { bg = "#212236" },
  TbLineBufOffModified = { bg = "#212236" },
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },

  GitsignsDiffAdd = { fg = git_colors.green, bg = "NONE" },
  GitsignsDiffAdded = { fg = "NONE", bg = git_colors.green },
  GitsignsDiffChange = { fg = git_colors.green, bg = git_colors.dark_green },
  GitsignsDiffChangeDelete = { fg = git_colors.white, bg = git_colors.dark_blue },
  GitsignsDiffModified = { fg = "NONE", bg = git_colors.dark_blue },
  GitsignsDiffDelete = { fg = "red", bg = "NONE" },
  GitsignsDiffRemoved = { fg = "NONE", bg = git_colors.red },

  NeogitChangeDeleted = { fg = "NONE", bg = git_colors.dark_red },
  NeogitDiffDelete = { fg = "NONE", bg = git_colors.dark_red },
  NeogitChangeDeleteLn = { fg = "NONE", bg = git_colors.dark_red },
  NeogitChangeDeleteNr = { fg = "NONE", bg = git_colors.dark_red },
  NeogitDiffDeleteHighlight = { fg = "#ffffff", bg = git_colors.dark_red },
  NeogitDiffHeader = { fg = git_colors.orange },
  NeogitDiffHeaderHighlight = { fg = git_colors.orange },

  IndentBlanklineIndent1 = { fg = "#0f3136" },
  IndentBlanklineIndent2 = { fg = "#325a5e" },
  IndentBlanklineIndent3 = { fg = "#324b7b" },
  IndentBlanklineIndent4 = { fg = "#216631" },
  IndentBlanklineIndent5 = { fg = "#563931" },
  IndentBlanklineIndent6 = { fg = "#662121" },
  IndentBlanklineIndent7 = { fg = "#562155" },
  IndentBlanklineIndent8 = { fg = "#563366" },
  IblScope = { fg = "#919db5" },

  Visual = { bg = "#636363" },
}

return M
