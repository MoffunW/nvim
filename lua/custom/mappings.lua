-- Mapping
local map = function(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "H", "^")
map("n", "L", "$")
map("v", "H", "^")
map("v", "L", "$")

-- redo
map("n", "U", "<C-r>")
map("n", "<C-z>", "u")

map("n", "<C-c>", '"y')
map("n", "<C-v>", '"p')
map("i", "<C-c>", '"y')
map("i", "<C-v>", '"p')
map("v", "<C-c>", '"y')
map("v", "<C-v>", '"p')

map("n", "<F1>", "<Esc>")
map("v", "<F1>", "<Esc>")
map("i", "<F1>", "<Esc>")
map("x", "<F1>", "<Esc>")

-- Increment / Decrement
map("n", "=", "<C-a>")
map("n", "-", "<C-x>")

local options = { remap = true, nowait = true, silent = true }

---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<leader>h"] = "",
    ["<C-a>"] = "",
    ["<C-c>"] = "",
    ["<C-v>"] = "",
    ["<C-BS>"] = "",
    -- Gitsigns
    ["]c"] = "",
    ["[c"] = "",
    ["<leader>gb"] = "",

    -- Nvimtree
    ["<C-n>"] = "",

    -- Telescope
    ["<leader>pt"] = "",
    ["<leader>cm"] = "",
    ["<leader>gt"] = "",

    -- lspconfig
    ["<leader>f"] = "",
    ["K"] = "",
    -- Lspconfig
    ["<leader>gt"] = "",
  },
}

M.general = {
  n = {
    -- Move faster
    ["J"] = { "5j", "down 5 lines", opts = options },
    ["K"] = { "5k", "up 5 lines", opts = options },

    -- Move lines
    ["<A-j>"] = { "<cmd>m+<CR>", "Move lines down", opts = options },
    ["<A-k>"] = { "<cmd>m-2<CR>", "Move lines up", opts = options },

    -- Indent
    [">"] = { ">1>", "indent right", opts = options },
    ["<"] = { "<<", "indent left", opts = options },

    -- Close all buffer
    ["<A-x>"] = { ":BufOnly<CR>", "Close other buffers", opts = { remap = true, silent = true } },

    -- Other
    ["<Esc>"] = { ":noh <CR>", "Clear highlights", opts = options },
  },

  i = {
    -- Save file
    ["<C-s>"] = { "<cmd> w <CR>", "Save file", opts = options },
  },

  v = {
    -- Move faster
    ["J"] = { "5j", "down 5 lines", opts = options },
    ["K"] = { "5k", "up 5 lines", opts = options },

    -- Move lines
    ["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move lines down", opts = options },
    ["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move lines up", opts = options },
    -- Indent
    [">"] = { ">gv", "indent", opts = options },
    -- Search
    ["/"] = { 'y/<c-r>"<CR>', "Search", opts = options },
  },
}

M.hop = {
  plugin = true,
  -- vim hop
  n = {

    ["f"] = {
      function()
        local hop = require "hop"
        local directions = require("hop.hint").HintDirection

        hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
      end,
    },

    ["F"] = {
      function()
        local hop = require "hop"
        local directions = require("hop.hint").HintDirection

        hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
      end,
    },

    ["S"] = { "<cmd> HopWord <CR>", "HopWord", opts = { remap = true, nowait = true, silent = true } },
    ["s"] = { "<cmd> HopWord <CR>", "HopWord", opts = { remap = true, nowait = true, silent = true } },
  },
  v = {

    ["f"] = {
      function()
        local hop = require "hop"
        local directions = require("hop.hint").HintDirection

        hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
      end,
    },

    ["F"] = {
      function()
        local hop = require "hop"
        local directions = require("hop.hint").HintDirection

        hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
      end,
      "Hop forward",
    },

    ["S"] = { "<cmd> HopWord <CR>", "HopWord", opts = { remap = true, nowait = true, silent = true } },
    ["s"] = { "<cmd> HopWord <CR>", "HopWord", opts = { remap = true, nowait = true, silent = true } },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },
  i = {
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<C-_>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    ["<leader>tt"] = { "<cmd> Telescope <CR>", "Open telescope" },

    -- find
    ["<leader>fs"] = { "<cmd> Telescope persisted<CR>", "Find sessions" },
    ["<leader>fh"] = { "<cmd> Telescope search_history<CR>", "Search history" },
    ["<leader>fc"] = { "<cmd> Telescope command_history<CR>", "Command history" },
    ["<leader>ft"] = { "<cmd> Telescope terms<CR>", "Pick hidden term" },
    ["<leader>fj"] = { "<cmd> Telescope jumplist<CR>", "Find jumplist" },
    ["<leader>fu"] = { "<cmd> Telescope resume<CR>", "Reopen previous window" },

    -- git
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },
    ["<leader>gf"] = { "<cmd> Telescope git_files <CR>", "Git files" },
    ["<leader>gg"] = { "<cmd> Neogit <CR>", "open Neogit" },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks

    ["gn"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },
    ["gN"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },
  },
}

M.lspconfig = {
  plugin = true,

  n = {
    ["gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },
    ["<leader>fp"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
  },
}

-- more keybinds!

return M
