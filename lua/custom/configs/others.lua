local M = {}

-- M.neogit = {
--   disable_context_highlighting = false,
--   disable_commit_confirmation = true,
--   integrations = { diffview = true, telescope = true },
--   signs = {
--     -- { CLOSED, OPENED }
--     section = { "", "" },
--     item = { "", "" },
--     hunk = { "", "" },
--   },
-- }

M.blankline = {
  enabled = true,
  debounce = 200,
  viewport_buffer = {
    min = 30,
    max = 500,
  },
  indent = {
    char = "▎",
    tab_char = "▎",

    highlight = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
      "IndentBlanklineIndent7",
      "IndentBlanklineIndent8",
    },
    smart_indent_cap = true,
    priority = 1,
  },
  whitespace = {
    remove_blankline_trail = true,
  },
  scope = {
    show_start = false,
    highlight = "IblScope",
  },
  exclude = {
    filetypes = {
      "fugitive",
      "fugitiveblame",
      "Jaq",
      "qf",
      "fzf",
      "help",
      "man",
      "dap-repl",
      "DressingSelect",
      "OverseerList",
      "Markdown",
      "git",
      "PlenaryTestPopup",
      "lspinfo",
      "notify",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "neotest-output",
      "checkhealth",
      "neotest-summary",
      "neotest-output-panel",
    },
    buftypes = {
      "terminal",
      "nofile",
      "quickfix",
      "prompt",
    },
  },
}


return M
