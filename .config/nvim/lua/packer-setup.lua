-- INSTALL packer {{{
local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command(
        '!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end
-- }}}

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- packer
    use {'wbthomason/packer.nvim', opt = true}

    -- LSP
    use {'neovim/nvim-lspconfig'}
    use {'onsails/lspkind-nvim'}
    use {'kabouzeid/nvim-lspinstall'}
    use {'hrsh7th/nvim-compe'}
    -- use {'nvim-lua/completion-nvim'}

    -- Debugging
    use {'puremourning/vimspector'}
    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }
    use {
        'szw/vim-maximizer',
        config = function() require 'plugins/szw-vim-maximizer' end
    }

    -- Explorer
    use {'preservim/nerdtree'}
    use {'Xuyuanp/nerdtree-git-plugin'}

    -- Editor UI
    -- use {'kyazdani42/nvim-tree.lua'}
    use {'glepnir/galaxyline.nvim'}
    use {'norcalli/nvim-colorizer.lua'}
    use {'ryanoasis/vim-devicons'}
    use {'kyazdani42/nvim-web-devicons'}

    -- Tree Shitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}

    -- Telescope
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-lua/popup.nvim'}
    use {'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-symbols.nvim'}
    use {'nvim-telescope/telescope-fzy-native.nvim'}
    use {'nvim-telescope/telescope-media-files.nvim'}

    -- Git
    use {'tpope/vim-fugitive'}
    use {'rhysd/git-messenger.vim'}
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'gisphm/vim-gitignore'}

    -- Utilities
    use {'voldikss/vim-floaterm'}
    use {'sirver/ultisnips'}
    use {'mbbill/undotree'}
    use {'preservim/tagbar'}
    -- use {'mhinz/vim-startify'}
    use {'unblevable/quick-scope'}
    use {'andymass/vim-matchup'}
    use {'junegunn/goyo.vim'}
    use {'junegunn/limelight.vim'}
    use {'machakann/vim-highlightedyank'}

    -- Cheat Sheet
    use {'RishabhRD/popfix'}
    use {'RishabhRD/nvim-cheat.sh'}

    -- Formatting
    use {'windwp/nvim-autopairs'}
    use {'tpope/vim-surround'}
    use {'terrortylor/nvim-comment'}
    use {'junegunn/vim-easy-align'}
    use {'sbdchd/neoformat'}

    -- Filetypes
    use {'lervag/vimtex', ft = 'tex'}
    use {'iamcco/markdown-preview.nvim', ft = 'markdown'}
    use {'octol/vim-cpp-enhanced-highlight'}
    use {'dag/vim-fish'}
    use {'vimwiki/vimwiki'}

    -- Tmux
    use {
        'christoomey/vim-tmux-navigator',
        config = function()
            require 'plugins/christoomey-vim-tmux-navigator'
        end
    }

    -- Colorscheme
    use {'glepnir/oceanic-material'}
    use {'sainnhe/gruvbox-material'}
    use {'gruvbox-community/gruvbox'}
    use {'arcticicestudio/nord-vim'}
    use {'joshdick/onedark.vim'}
end)
