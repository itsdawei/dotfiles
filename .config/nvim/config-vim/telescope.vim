lua require("dawei")

nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <Leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <Leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>vrc :lua require('dawei.telescope').search_dotfiles()<CR>
nnoremap <leader>gc :lua require('dawei.telescope').git_branches()<CR>
