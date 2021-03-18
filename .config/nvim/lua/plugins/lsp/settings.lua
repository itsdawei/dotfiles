-- local on_attach = require'completion'.on_attach
local lsp = require"lspconfig"
lsp.texlab.setup{}
lsp.sourcekit.setup{
    filetypes = { "swift" }
}
lsp.tsserver.setup{}
lsp.clangd.setup {
    root_dir = function() return vim.loop.cwd() end
}
lsp.pyls.setup{}
lsp.cssls.setup{}
lsp.html.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = false,
  }
)

vim.o.completeopt = "menuone,noinsert,noselect"

require "compe".setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = false,
    source = {
        path = true,
        buffer = true,
        calc = true,
        UltiSnips = true,
        nvim_lsp = true,
        nvim_lua = true,
        spell = true,
        tags = true,
        treesitter = true
    }
}

require("lspkind").init(
    {
        File = " "
    }
)
