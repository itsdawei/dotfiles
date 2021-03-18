local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {noremap = true, silent = true}

map("n", "<leader>vd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "<leader>vD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "<leader>vi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<leader>vsh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<leader>vsd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
map("n", "<leader>vn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
map("n", "<leader>vll", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
-- map("n", "<leader>vsh", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
