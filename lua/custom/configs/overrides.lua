local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "vue",
    "javascript",
    "typescript",
    "scss",
    "css",
    "html",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
  },
  compilers = { "clang" },
}

M.cmp = {
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "vue-language-server",
    "emmet-ls",
    "prettierd",

    -- c/cpp stuff
    "clangd",
    "clang-format",
  },
}

-- M.telescope = {
--   file_ignore_patterns = { "node_modules", "*-lock.json", "*.lock", "yarn.lock" },
--   extensions_list = { "themes", "terms", "fzf", "persisted" },
--   extensions = {
--     fzf = {
--       fuzzy = true,
--       override_generic_sorter = true,
--       override_file_sorter = true,
--       case_mode = "smart_case",
--     },
--     persisted = {
--       layout_config = { width = 0.55, height = 0.55 },
--     },
--   },
-- }
--
--

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.ibl = {
  char_highlight_list = {
    "IndentBlanklineIndent1",
    "IndentBlanklineIndent2",
    "IndentBlanklineIndent3",
    "IndentBlanklineIndent4",
    "IndentBlanklineIndent5",
    "IndentBlanklineIndent6",
  },
}

return M
