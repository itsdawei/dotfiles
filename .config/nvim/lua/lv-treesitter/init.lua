require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
    indent = {enable = true, disable = {"python", "html", "javascript"}},
    autotag = {enable = true}
}

