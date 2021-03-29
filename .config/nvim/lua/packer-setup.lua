local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require("packer").startup(
    function()
        -- packer
        use {"wbthomason/packer.nvim", opt = true}

        -- Editor UI
        use {"preservim/nerdtree"}
        use {"Xuyuanp/nerdtree-git-plugin"}
        use {"ryanoasis/vim-devicons"}
        use {"glepnir/galaxyline.nvim"}
        use {"norcalli/nvim-colorizer.lua"}
        use {"lukas-reineke/indent-blankline.nvim", branch = 'lua'}

        -- LSP Support
        use {"neovim/nvim-lspconfig"}
        use {"nvim-lua/completion-nvim"}
        -- use {"hrsh7th/nvim-compe"}
        use {"onsails/lspkind-nvim"}

        -- Tree Shitter
        use {"nvim-treesitter/nvim-treesitter"}

        -- Debugger Plugins
        use {"tpope/vim-dispatch"}
        use {"puremourning/vimspector"}
        use {"szw/vim-maximizer"}

        -- Telescope
        use {"nvim-lua/plenary.nvim"}
        use {"nvim-lua/popup.nvim"}
        use {"nvim-telescope/telescope.nvim"}
        use {"nvim-telescope/telescope-symbols.nvim"}
        use {"nvim-telescope/telescope-fzy-native.nvim"}

        -- Git
        use {"tpope/vim-fugitive"}
        use {"rhysd/git-messenger.vim"}
        use {"gisphm/vim-gitignore"}
        -- use {"lewis6991/gitsigns.nvim"}
        use {"airblade/vim-gitgutter"}

        -- Utilities
        use {"voldikss/vim-floaterm"}
        use {"sirver/ultisnips"}
        use {"mbbill/undotree"}
        use {"preservim/tagbar"}
        -- use {"mhinz/vim-startify"}
        use {"unblevable/quick-scope"}
        use {"junegunn/goyo.vim"}
        use {"junegunn/limelight.vim"}

        -- Cheat Sheet
        use {"RishabhRD/popfix"}
        use {"RishabhRD/nvim-cheat.sh"}

        -- Formatting
        use {"windwp/nvim-autopairs"}
        use {"tpope/vim-surround"}
        use {"tpope/vim-commentary"}
        use {"junegunn/vim-easy-align"}
        use {"sbdchd/neoformat"}

        -- Filetypes
        use {"lervag/vimtex", ft = "tex"}
        use {"iamcco/markdown-preview.nvim", ft = "markdown"}
        use {"octol/vim-cpp-enhanced-highlight"}
        use {"vimwiki/vimwiki"}

        -- Colorscheme
        use {"glepnir/oceanic-material"}
        use {"sainnhe/gruvbox-material"}
        use {"arcticicestudio/nord-vim"}
        use {"joshdick/onedark.vim"}
    end
)
