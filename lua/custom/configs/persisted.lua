local options = {
  should_autosave = true,
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

return options
