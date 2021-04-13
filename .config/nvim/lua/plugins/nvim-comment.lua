require('nvim_comment').setup()
Keybind.g({
    {"n", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true}},
    {"v", "<leader>/", ":CommentToggle<CR>", {noremap = true, silent = true}},
})
