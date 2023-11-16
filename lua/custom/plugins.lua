local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

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
    cmd = "Neogit",
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
    cmd = "BufOnly",
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
