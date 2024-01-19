local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { -- Optional
        "williamboman/mason.nvim",
        opts = overrides.mason,
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" }, -- Required
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = overrides.ibl,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "olimorris/persisted.nvim",
    cmd = {
      "SessionToggle",
      "SessionStart",
      "SessionStop",
      "SessionSave",
      "SessionLoad",
      "SessionLoadLast",
      "SessionLoadLastFromFile",
      "SessionDelete",
    },
    lazy = false,

    opts = function()
      return require "custom.configs.persisted"
    end,
    config = function(_, opts)
      require("persisted").setup(opts)
    end,
    init = function()
      local group = vim.api.nvim_create_augroup("PersistedHooks", {})

      -- Close all plugin owned buffers before saving a session.
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedSavePre",
        group = group,
        callback = function()
          -- Detect if window is owned by plugin by checking buftype.
          local current_buffer = vim.api.nvim_get_current_buf()
          for _, win in ipairs(vim.fn.getwininfo()) do
            local buftype = vim.bo[win.bufnr].buftype
            if buftype ~= "" and buftype ~= "help" then
              -- Delete plugin owned window buffers.
              if win.bufnr == current_buffer then
                -- Jump to previous window if current window is not a real file
                vim.cmd.wincmd "p"
              end
              vim.api.nvim_buf_delete(win.bufnr, {})
            end
          end
          pcall(vim.cmd, "bw NvimTree")
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedSavePost",
        group = group,
        callback = function()
          require("persisted").stop()
        end,
      })

      -- Before switching to a different session using Telescope, save and stop
      -- current session to avoid previous session to be overwritten.
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedTelescopeLoadPre",
        group = group,
        callback = function()
          vim.api.nvim_command "%bd"
          require("persisted").stop()
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedLoadPre",
        group = group,
        callback = function()
          vim.api.nvim_command "%bd"
          for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(win).zindex then
              vim.api.nvim_win_close(win, false)
            end
          end
        end,
      })

      --[[ vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedTelescopeLoadPre",
        group = group,
        callback = function(session)
          -- vim.api.nvim_command "%bw"
        end,
      }) ]]

      -- After switching to a different session using Telescope, start it so it
      -- will be auto-saved.
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedTelescopeLoadPost",
        group = group,
        callback = function(session)
          require("persisted").start()
          pcall(vim.cmd, "bw NvimTree")

          print("Started session " .. session.data.name)
        end,
      })
    end,
  },

  -- git stuff
  {
    "NeogitOrg/neogit",
    lazy = true,
    cmd = "Neogit",
    commit = "159c545",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    opts = function()
      return require "custom.configs.neogit"
    end,

    -- config = true
    config = function(_, opts)
      require("neogit").setup(opts)
    end,
  },
  -- Move faster
  {
    "phaazon/hop.nvim",
    lazy = true,
    branch = "v2",
    cmd = { "HopChar1CurrentLineAC", "HopChar1CurrentLineBC", "HopChar2MW", "HopWordMW" },
    config = function()
      local hop = require "hop"
      hop.setup { keys = "etovxqpdygfblzhckisuran" }
    end,
    init = require("core.utils").load_mappings "hop",
  },
  {
    "numtostr/BufOnly.nvim",
    lazy = true,
    cmd = "BufOnly",
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    cmd = {
      "TodoTelescope",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    config = function()
      require("neoscroll").setup {

        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
      }
    end,
    init = function()
      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50" } }
      t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50" } }
      t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "50" } }
      t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "50" } }
      t["<C-y>"] = { "scroll", { "-0.10", "false", "50" } }
      t["<C-e>"] = { "scroll", { "0.10", "false", "50" } }
      t["zt"] = { "zt", { "50" } }
      t["zz"] = { "zz", { "50" } }
      t["zb"] = { "zb", { "50" } }

      require("neoscroll.config").set_mappings(t)
    end,
  },
  {
    "booperlv/nvim-gomove",
    -- lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gomove").setup {
        map_defaults = true,
        -- whether or not to reindent lines moved vertically (true/false)
        reindent = true,
        -- whether or not to undojoin same direction moves (true/false)
        undojoin = true,
        -- whether to not to move past end column when moving blocks horizontally, (true/false)
        move_past_end_col = false,
      }
    end,
    -- init = require("core.utils").load_mappings "hop",
  },
}

return plugins
