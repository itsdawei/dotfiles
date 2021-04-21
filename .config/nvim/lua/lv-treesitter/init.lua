require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = O.treesitter.highlight.enabled
    },
    -- indent = {enable = true, disable = {"python", "html", "javascript"}},
    -- TODO seems to be broken
    indent = {enable = {"javascriptreact"}},
    autotag = {enable = true}
}

