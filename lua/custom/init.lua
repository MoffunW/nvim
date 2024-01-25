-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
--
vim.g.emmet_enabled = false
function ToggleEmmet()
  -- Check if the current buffer is a Vue file
  if vim.bo.filetype == "vue" then
    -- Get the current line and column
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --
    -- Parse the entire Vue file
    local parser = vim.treesitter.get_parser(0, "vue")
    local parseResult = parser:parse()

    -- Check if the parse result is not empty
    if #parseResult ~= 0 then
      local root = parseResult[1]:root()
      local templateNode = root:named_descendant_for_range(line, col, line, col):parent()
      local isTemplate = templateNode
        and templateNode:type() ~= "style_element"
        and templateNode:type() ~= "script_element"

      -- Check if the node is a <template> node
      if isTemplate then
        vim.g.emmet_enabled = true
      else
        vim.g.emmet_enabled = false
      end
    end
  end
end

-- Use the CursorHold event to call ToggleEmmet
vim.cmd [[autocmd CursorHold * lua ToggleEmmet()]]

vim.o.swapfile = false
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
