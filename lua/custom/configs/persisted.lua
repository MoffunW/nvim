local M = {}

function M.init()
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
end

M.options = {
  -- should_autosave = true,
  autoload = true,
  on_autoload_no_session = function()
    print "No existing session to load."
  end,
  telescope = {
    reset_prompt_after_deletion = true,
    before_source = function()
      vim.api.nvim_command "%bd"
    end,
    after_source = function(param)
      -- vim.api.nvim_command "%bd"
      local path = param.dir_path
      if string.find(path, "/") ~= 1 then
        vim.api.nvim_command("cd " .. vim.fn.expand "~" .. "/" .. path)
        vim.api.nvim_command("tcd " .. vim.fn.expand "~" .. "/" .. path)
      else
        vim.api.nvim_command("cd " .. path)
        vim.api.nvim_command("tcd " .. path)
      end
    end,
  },
}

-- return options
return M
