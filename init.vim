" Genral Setting
"---------------------
filetype plugin indent on
syntax on
set showmatch
set undodir=~/.local/share/nvim/site/undodir
set undofile
set undolevels=500
set nobackup
set noswapfile
set hidden                                  " Needed to keep multiple buffers open
set nu rnu                                  " relative line numbering
set nohls                                   " highlight search
set listchars=tab:>>,nbsp:~                 " set list to see tabs and non-breakable spaces
set lbr                                     " line break
set scrolloff=4                             " show lines above and below cursor (when possible)
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set lazyredraw                              " skip redrawing screen in some cases
set hidden                                  " allow auto-hiding of edited buffers
set confirm
set ignorecase smartcase
set wildmode=longest,list
set mouse+=a                                " enable mouse mode (scrolling, selection, etc)
set noerrorbells
set updatetime=50
set completeopt=menuone,noinsert,noselect shortmess+=c
set pumheight=7

set expandtab
set smartindent autoindent
set tabstop=4 softtabstop=4
set shiftwidth=4

set t_Co=256
set guifont=Hack\ Nerd\ Font:h13
set conceallevel=2
set concealcursor-=n

function! s:patch_gruvbox_colors()
    hi Normal ctermbg=None
    hi LineNr ctermfg=DarkGrey
endfunction

autocmd! ColorScheme gruvbox call s:patch_gruvbox_colors()
colorscheme gruvbox

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

"--------------------
" Splits and Tabbed Files
"--------------------
set splitbelow splitright
set fillchars+=vert:\ 

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'

"--------------------
" Misc configurations
"--------------------
set mmp=5000
set spelllang=en_us

" Magic cursor switching
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"--------------------
" Mappings
"--------------------
let mapleader = ' '

"imap ii <ESC>
nnoremap j gj
nnoremap k gk
nnoremap < <<
nnoremap > >>

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
noremap <LEADER>vc :vsp ~/.config/nvim/init.vim<CR>

" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>

"------------------
" Vim-Plug
"------------------
call plug#begin('~/.config/nvim/plugged')
    
"{{ The Basics }}
    Plug 'yggdroot/indentline'
    Plug 'tpope/vim-fugitive'

"{{ File Management }}
    Plug 'preservim/nerdtree'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

"{{ Code Navigation }}
    Plug 'preservim/tagbar'
    Plug 'haya14busa/incsearch.vim'

"{{ LSP Support }}
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    Plug 'nvim-lua/diagnostic-nvim'
 
"{{ Formatting }}
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'junegunn/vim-easy-align'
    Plug 'sjl/gundo.vim'

"{{ Syntax Highlighting }}
    Plug 'luochen1990/rainbow'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'keith/swift.vim'
    Plug 'octol/vim-cpp-enhanced-highlight'

"{{ Snippets }}
    Plug 'sirver/ultisnips'
    "Plug 'honza/vim-snippets'

"{{ Productivity }}
    Plug 'junegunn/goyo.vim'
    Plug 'vimwiki/vimwiki'

"{{ Color Scheme }}
    Plug 'itchyny/lightline.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'ryanoasis/vim-devicons'

"{{ Latex Related }}
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex'}
    "Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
 
"{{ Markdown Related }}
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

    Plug 'theprimeagen/vim-be-good'

call plug#end()

"------------------
" Basics
"------------------
" indentline
"let g:indentLine_concealcursor = ''
let g:indentLine_fileTypeExclude = ['markdown','vimwiki']

" lightline
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

"------------------
" File Management
"------------------
" NERDTree
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>o :NERDTreeToggle %<CR> 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI=1
let g:NERDTreeWinSize=38 

" fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>b :Buffers<CR>

"------------------
" Code Navigation
"------------------
" Tagbar
nmap <Leader>t :TagbarToggle<CR>

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"------------------
" LSP Support
"------------------
let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1
let g:vimsyn_embed= 'l'
let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_matching_smart_case = 1
let g:completion_trigger_on_delete = 1

"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('completion').on_attach()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end
  local servers = {'clangd', 'pyls', 'sourcekit'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

"lua require'lspconfig'.sourcekit.setup{on_attach=require'completion'.on_attach, settings={filetypes={"swift"}}}
command! Format execute 'lua vim.lsp.buf.formatting()'
nnoremap <Leader>F :Format<CR>
 
"------------------
" Formatting
"------------------
" vim-commentary

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" gundo
nnoremap <Leader>u :GundoToggle<CR>
if has('python3')
    let g:gundo_prefer_python3=1
endif

"---------------------
" Syntax Highlighting
"---------------------
" Treesitter
:lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = { },
    },
  }
    require "nvim-treesitter.parsers".get_parser_configs().markdown = nil
EOF

" vim-rainbow
let g:rainbow_active=1
let g:rainbow_conf = {
	\	'separately': {
	\		'nerdtree': 0,
	\	}
	\}

"---------------------
" Snippets
"---------------------
" ultisnips
"let g:UltiSnipsSnippetDirectories = ["/Users/helen/.config/nvim/vim-snips"]
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsEditSplit="vertical"

"---------------------
" Productivity
"---------------------
" Goyo & Limelight
map <LEADER>gy :Goyo<CR>

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_eop = '\ze\n^\s'
let g:limelight_priority = -1

function! s:goyo_enter()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status off
        silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight
endfunction

function! s:goyo_leave()
    if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set showmode
    set showcmd
    set scrolloff=5
    Limelight!
    colorscheme gruvbox
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" vimwiki
autocmd FileType vimwiki UltiSnipsAddFiletypes vimwiki
let g:vimwiki_global_ext = 0
let g:vimwiki_table_mappings = 0
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown',
                      \ }]

"--------------------
" Latex Related
"---------------------
let g:livepreview_previewer='open -a Skim'
let g:livepreview_engine='xelatex'
let g:tex_flavor='latex'
"let g:tex_conceal='abdmg'
let g:tex_conceal=""
let g:tex_conceal_frac=1
hi Conceal ctermbg=none
autocmd Filetype tex setl updatetime=400

"---------------------
" Markdown Related
"---------------------
nnoremap <Leader>mm :MarkdownPreview<CR>
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1
"let g:vim_markdown_conceal=2
let g:markdown_fenced_languages=['swift', 'vim']

let g:mkdp_auto_close=0
let g:mkdp_filetypes = ['markdown', 'vimwiki']
