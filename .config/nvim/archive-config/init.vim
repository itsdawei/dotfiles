" Install vim-plug if not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

set exrc

call plug#begin('~/.vim/plugged')
" {{ Editor UI }}
    Plug 'ryanoasis/vim-devicons'
    Plug 'glepnir/oceanic-material'
    Plug 'gruvbox-community/gruvbox'
    Plug 'itchyny/lightline.vim'

"{{ LSP Support }}
    Plug 'neovim/nvim-lspconfig'
    " Plug 'nvim-lua/completion-nvim'
    Plug 'hrsh7th/nvim-compe'
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
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

"{{ FZF and Git }}
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'

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

"{{ FileTypes }}
    " Plug 'lervag/vimtex', {'for': 'tex'}
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex'}
    Plug 'iamcco/markdown-preview.nvim', {'for': 'markdown'}
    Plug 'octol/vim-cpp-enhanced-highlight'

"{{ Prettier }}
    Plug 'sbdchd/neoformat'

    Plug 'tpope/vim-dispatch'
    Plug 'vimwiki/vimwiki'

call plug#end()


lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

nnoremap j gj
nnoremap k gk
nnoremap < <<
nnoremap > >>

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :Ex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>rp :resize 100<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

com! WQ wq
com! Wq wq
com! Wqa wqa
com! W w
com! Q q

vnoremap <leader>p "_dP

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <leader>d "_d
vnoremap <leader>d "_d

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
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END
