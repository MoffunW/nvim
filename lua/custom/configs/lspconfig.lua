local lspconfig = require "lspconfig"
local lspZero = require "lsp-zero"

lspZero.preset "minimal"
lspZero.on_attach(function(client, bufnr)
  lspZero.default_keymaps {
    buffer = bufnr,
  }
end)

lspZero.format_on_save {
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ["lua_ls"] = { "lua" },
    -- if you have a working setup with null-ls
    -- you can specify filetypes it can format.

    ["tsserver"] = { "javascript", "typescript" },
    ["volar"] = { "vue" },
    ["prettierd"] = { "html", "vue", "javascript", "typescript" },
    ["emmet_ls"] = { "vue", "html" },
    ["cssls"] = { "vue", "css", "scss" },
    ["html-lsp"] = { "html" },
  },
}

lspZero.setup()

-- if you just want default config for the servers then put them in a table
-- local servers = { "volar", "tsserver", "clangd", "cssls", "gopls" }
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local servers = { "volar", "tsserver", "clangd", "cssls", "html" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require("lspconfig").emmet_ls.setup {
  enabled = vim.g.emmet_enabled,
  capabilities = capabilities,
  filetypes = { "html", "javascriptreact", "typescriptreact", "vue" },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = false,
        ["bem.element"] = "__",
        ["bem.modifier"] = "--",
      },
    },
  },
}
