local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end

-- language servers
local lsp = require "lspconfig"
lsp.texlab.setup {}
lsp.sourcekit.setup {filetypes = {"swift"}}
lsp.tsserver.setup {}
lsp.clangd.setup {root_dir = function() return vim.loop.cwd() end}
lsp.pyls.setup {}
lsp.cssls.setup {
    cmd = {
        "node", DATA_PATH .. "/lspinstall/css/vscode-css/css-language-features/server/dist/node/cssServerMain.js",
        "--stdio"
    },
    on_attach = require'lsp'.common_on_attach
}
lsp.html.setup {}
lsp.bashls.setup {
    cmd = {DATA_PATH .. "/lspinstall/bash/node_modules/.bin/bash-language-server", "start"},
    on_attach = require'lsp'.common_on_attach,
    filetypes = { "sh", "zsh" }
}
lsp.dockerls.setup {
    cmd = {DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver", "--stdio"},
    on_attach = require'lsp'.common_on_attach,
	root_dir = vim.loop.cwd
}

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.expand('$HOME/lua-language-server')
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name ..
                           "/lua-language-server"
lsp.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim'}},
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}

-- diagnostic
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = false
    })

-- completion-nvim
Variable.g({
    completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'},
    vimsyn_embed = 'l',
    completion_confirm_key = '',
    completion_enable_snippet = 'UltiSnips',
    completion_trigger_on_delete = 1,
    completion_chain_complete_list = {
        {complete_items = {'snippet', 'lsp'}}, {mode = '<c-p>'},
        {mode = '<c-n>'}
    }
})

vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        ultisnips = {kind = "  "},
        path = {kind = "  "},
        buffer = {kind = "  "},
        calc = {kind = "  "},
        -- vsnip = {kind = "  "},
        nvim_lsp = {kind = "  "},
        -- nvim_lua = {kind = "  "},
        nvim_lua = false,
        spell = {kind = "  "},
        tags = false,
        -- snippets_nvim = {kind = "  "},
        treesitter = {kind = "  "},
        emoji = {kind = " ﲃ ", filetypes = {"markdown"}}
    }
}
