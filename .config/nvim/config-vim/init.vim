" Install vim-plug if not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')
" Editor UI
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'glepnir/galaxyline.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch' : 'lua' }

" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" use {'hrsh7th/nvim-compe'}
Plug 'onsails/lspkind-nvim'

" Tree Shitter
Plug 'nvim-treesitter/nvim-treesitter'

" Debugger Plugins
Plug 'tpope/vim-dispatch'
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-symbols.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'
Plug 'gisphm/vim-gitignore'
Plug 'airblade/vim-gitgutter'

" Utilities
Plug 'voldikss/vim-floaterm'
Plug 'sirver/ultisnips'
Plug 'mbbill/undotree'
Plug 'preservim/tagbar'
" use {'mhinz/vim-startify'}
Plug 'unblevable/quick-scope'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Cheat Sheet
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-cheat.sh'

" Formatting
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'sbdchd/neoformat'

" Filetypes
Plug 'lervag/vimtex', { 'for' : 'tex' }
Plug 'iamcco/markdown-preview.nvim', { 'for' : 'markdown' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vimwiki/vimwiki'

" Colorscheme
Plug 'glepnir/oceanic-material'
Plug 'sainnhe/gruvbox-material'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'

call plug#end()

lua << EOF
-- generics
require('utils')

-- vim core settings
Reload.reload_module('general')
require('general')

-- vim plugins settings
Reload.reload_module('plugins')
require('plugins')

-- require('packer-setup')
EOF
