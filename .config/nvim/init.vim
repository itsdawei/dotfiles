" Install vim-plug if not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

set exrc

call plug#begin('~/.vim/plugged')

"{{ LSP Support }}
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'tjdevries/nlua.nvim'
    Plug 'tjdevries/lsp_extensions.nvim'

"{{ Tree Shitter }}
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"{{ Debugger Plugins }}
    Plug 'puremourning/vimspector'
    Plug 'szw/vim-maximizer'

"{{ Telescope }}
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/telescope.nvim'

"{{ FZF and Git }}
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'stsewd/fzf-checkout.vim'

"{{ Utilities }}
    Plug 'sirver/ultisnips'
    Plug 'mbbill/undotree'
    Plug 'preservim/tagbar'
    Plug 'vim-utils/vim-man'
    Plug 'mhinz/vim-startify'

"{{ Formatting }}
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'junegunn/vim-easy-align'

"{{ Additional Syntax Highlighting }}
    Plug 'keith/swift.vim'

"{{ Colorful }}
    Plug 'ryanoasis/vim-devicons'
    Plug 'itchyny/lightline.vim'
    Plug 'gruvbox-community/gruvbox'

"{{ Latex Related }}
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex'}
    "Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

"{{ Markdown }}
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
    Plug 'godlygeek/tabular'

"{{ Fire Nvim }}
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(69) } }

"{{ Cheat Sheet }}
    Plug 'dbeniamine/cheat.sh-vim'

    Plug 'theprimeagen/vim-be-good'
    Plug 'tpope/vim-dispatch'
    " Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

imap jj <ESC>

nnoremap j gj
nnoremap k gk
nnoremap < <<
nnoremap > >>

vnoremap <leader>p "_dP

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>

lua << EOF
    require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
            disable = {"markdown", "css"},
        },
    }
EOF

let loaded_matchparen = 1
let mapleader = ' '

nnoremap <Leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
" nnoremap <Leader>h :wincmd h<CR>
" nnoremap <Leader>j :wincmd j<CR>
" nnoremap <Leader>k :wincmd k<CR>
" nnoremap <Leader>l :wincmd l<CR>
nnoremap <c-h> :wincmd h<CR>
nnoremap <c-j> :wincmd j<CR>
nnoremap <c-k> :wincmd k<CR>
nnoremap <c-l> :wincmd l<CR>
nnoremap <Leader>u :UndotreeShow<CR>
nnoremap <Leader>pv :Sex!<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
vnoremap J :m '>+1<CR>gv=gK
vnoremap K :m '<-2<CR>gv=gvr

com! WQ wq
com! Wq wq
com! Wqa wqa
com! W w
com! Q q

fun! TrimWhiteSpace()
    if &ft =~ 'markdown'
        return
    endif

    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

augroup HighlightYank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

augroup THE_PRIMEAGEN
    autocmd!
    autocmd BufWritePre * :call TrimWhiteSpace()
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
