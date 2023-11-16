local options = {
  disable_context_highlighting = false,
  disable_commit_confirmation = true,
  integrations = { diffview = true, telescope = true },
  signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
}

return options
