filetype plugin indent on
syntax on

set exrc

set t_Co=256
set conceallevel=2
set concealcursor=
set pumheight=8

set splitbelow splitright
" set fillchars+=vert:\ 

noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>

set mmp=5000
set spelllang=en_us

let mapleader = ' '

imap jj <ESC>

nnoremap j gj
nnoremap k gk
nnoremap < <<
nnoremap > >>

nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

nnoremap <Leader>rc :e ~/.config/nvim/init.vim<CR>
nnoremap <Leader>vrc :vsp ~/.config/nvim/init.vim<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>

call plug#begin('~/.config/nvim/plugged')

"{{ The Basics }}
    Plug 'mhinz/vim-startify'
    Plug 'tpope/vim-fugitive'
    Plug 'nathanaelkane/vim-indent-guides'
    " Plug 'itchyny/lightline.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"{{ LSP Support }}
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'

"{{ Debugger Plugins }}
    " Plug 'puremourning/vimspector'
    Plug 'szw/vim-maximizer'

"{{ File Management }}
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'stsewd/fzf-checkout.vim'

"{{ Code Navigation }}
    Plug 'preservim/tagbar'
    Plug 'haya14busa/incsearch.vim'

"{{ Formatting }}
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'sjl/gundo.vim'
    Plug 'junegunn/vim-easy-align'

"{{ Syntax Highlighting }}
    Plug 'keith/swift.vim'
    Plug 'octol/vim-cpp-enhanced-highlight'

"{{ Productivity }}
    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    Plug 'vuciv/vim-bujo'

"{{ Latex Related }}
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex'}
    "Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
 
"{{ Markdown Related }}
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

"{{ Fire Nvim }}
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(69) } }

"{{ Telescope }}
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/telescope.nvim'

    Plug 'sirver/ultisnips'
    Plug 'theprimeagen/vim-be-good'
    Plug 'tpope/vim-dispatch'

    Plug 'gruvbox-community/gruvbox'

call plug#end()

" [[ Startify ]]
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']                        },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
let g:startify_fortune_use_unicode = 1
let g:startify_bookmarks = [
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zshrc' },
            \ ]

let entry_format = "'   ['. index .']'. repeat(' ', (3 - strlen(index)))"
if exists('*WebDevIconsGetFileTypeSymbol')  " support for vim-devicons
    let entry_format .= ". WebDevIconsGetFileTypeSymbol(entry_path) .' '.  entry_path"
else
    let entry_format .= '. entry_path'
endif


" [[ NERDTree ]]
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>o :NERDTreeToggle %<CR> 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI=1
let g:NERDTreeWinSize=38 

" [[ FZF ]]


nnoremap <Leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <Leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>rp :resize 100<CR>
vnoremap J :m '>+1<CR>gv=gK
vnoremap K :m '<-2<CR>gv=gvr

" [[ Bujo ]]
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" [[ Tagbar ]]
nmap <Leader>t :TagbarToggle<CR>

" [[ IncSearch ]]
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" [[ Tree Shitter ]]
lua << EOF
    require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
            disable = {"markdown", "css"},
        },
    }
EOF

" [[ UltiSnips ]]
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsEditSplit="vertical"


" [[ LSP ]]
let g:vimsyn_embed = "l"
let g:completion_confirm_key = ""
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_trigger_on_delete = 1

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
command! Format execute 'lua vim.lsp.buf.formatting()'
nnoremap <Leader>F :Format<CR>
 
" [[ Easy Align ]]
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" [[ Gundo ]]
nnoremap <Leader>u :GundoToggle<CR>
if has('python3')
    let g:gundo_prefer_python3=1
endif

" [[ Lightline ]]
let g:lightline={
    \ 'component_function': {
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \ },
    \ 'colorscheme': 'gruvbox',
    \ }

function! MyFiletype()
return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" [[ Vimwiki ]]
let g:vimwiki_global_ext = 0
let g:vimwiki_key_mappings = { 'table_mappings': 0, }
let g:vimwiki_list = [{
	\ 'path': '~/vimwiki',
	\ 'template_path': '~/vimwiki/templates/',
	\ 'template_default': 'default',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'path_html': '~/vimwiki/site_html/',
	\ 'custom_wiki2html': 'vimwiki_markdown',
	\ 'template_ext': '.tpl'}]

" [[ Latex Live-Preview ]]
let g:livepreview_previewer='open -a Skim'
let g:livepreview_engine='xelatex'
let g:tex_flavor='latex'
"let g:tex_conceal='abdmg'
let g:tex_conceal=""
let g:tex_conceal_frac=1
autocmd Filetype tex setl updatetime=400

" [[ Markdown ]]
nnoremap <Leader>mm :MarkdownPreview<CR>
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1
let g:markdown_fenced_languages=['swift', 'vim']

let g:mkdp_auto_close=0
let g:mkdp_filetypes = ['markdown']
