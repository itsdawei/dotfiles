filetype plugin indent on
syntax on

set number relativenumber   " relative line numbering
set nohlsearch              " highlight search
set hidden                  " Needed to keep multiple buffers open
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.local/share/nvim/site/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=4             " show lines above and below cursor (when possible)
set noshowmode
set completeopt=menuone,noinsert,noselect 
set signcolumn=yes

set cmdheight=2
set updatetime=50
set shortmess+=cI
set colorcolumn=80

set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
set linebreak               " line break
set timeout timeoutlen=1000 ttimeoutlen=100 
set lazyredraw              " skip redrawing screen in some cases
set confirm
set wildmode=longest,list
set mouse+=a                " enable mouse mode (scrolling, selection, etc)

set smartindent autoindent

set t_Co=256
set conceallevel=2
set concealcursor=
set pumheight=8

augroup PatchHightlightAndColorScheme
    hi Conceal ctermbg=None
    hi Normal ctermbg=None
    hi LineNr ctermfg=DarkGrey
    colorscheme gruvbox
augroup END

augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

augroup HighlightYank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

set splitbelow splitright
set fillchars+=vert:\ 

noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'

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
    Plug 'itchyny/lightline.vim'
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
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
      \ 'rebase': {
      \   'prompt': 'Rebase> ',
      \   'execute': 'echo system("{git} rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'track': {
      \   'prompt': 'Track> ',
      \   'execute': 'echo system("{git} checkout --track {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-t',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

lua require('telescope').setup({defaults = {file_sorter = require('telescope.sorters').get_fzy_sorter}})

nnoremap <Leader>gc :GBranches<CR>
nnoremap <Leader>ga :Git fetch --all<CR>
nnoremap <Leader>grum :Git rebase upstream/master<CR>
nnoremap <Leader>grom :Git rebase origin/master<CR>
nnoremap <Leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <Leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <Leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <Leader>bs /<C-R>=escape(expand("<cWORD>"), "/")<CR><CR>
nnoremap <Leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
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
lua << EOF
    require'lspconfig'.clangd.setup{ on_attach=require'completion'.on_attach }
    require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
    require'lspconfig'.sourcekit.setup{ on_attach=require'completion'.on_attach,
                \ filetypes={"swift"}
                \ }
EOF

let g:vimsyn_embed = "l"
let g:completion_confirm_key = ""
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1

nnoremap <Leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <Leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <Leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <Leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <Leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <Leader>vsd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
    
" [[ Firenvim ]]
let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
    \ }
\ }
let fc = g:firenvim_config['localSettings']
let fc['https://youtube.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://instagram.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://twitter.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https://.*gmail.com.*'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://.*twitch.tv.*'] = { 'takeover': 'never', 'priority': 1 }
