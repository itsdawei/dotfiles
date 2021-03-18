-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require("packer").startup(
    function()
        -- packer
        use {"wbthomason/packer.nvim", opt = true}

        -- use {"kyazdani42/nvim-tree.lua"}
        -- use {"kyazdani42/nvim-web-devicons"}
        -- use {"akinsho/nvim-bufferline.lua"}

        -- Editor UI
        use {"preservim/nerdtree"}
				use {"Xuyuanp/nerdtree-git-plugin"}
        use {"ryanoasis/vim-devicons"}
        use {"glepnir/galaxyline.nvim"}
        use {"norcalli/nvim-colorizer.lua"}
        use {"Yggdroot/indentLine"}

        -- Colorscheme
        use {"glepnir/oceanic-material"}
        use {"gruvbox-community/gruvbox"}
        use {"arcticicestudio/nord-vim"}
        use {"joshdick/onedark.vim"}

        -- LSP Support
        use {"neovim/nvim-lspconfig"}
        use {"hrsh7th/nvim-compe"}
        use {"onsails/lspkind-nvim"}

        -- Tree Shitter
        use {"nvim-treesitter/nvim-treesitter"}

        -- Debugger Plugins
        use {"puremourning/vimspector"}
        use {"szw/vim-maximizer"}

        -- Telescope
        use {"nvim-telescope/telescope.nvim"}
        use {"nvim-telescope/telescope-symbols.nvim"}
        use {"nvim-telescope/telescope-fzy-native.nvim"}
        use {"nvim-lua/plenary.nvim"}
        use {"nvim-lua/popup.nvim"}

        -- Git
        use {"tpope/vim-fugitive"}
        use {"rhysd/git-messenger.vim"}
        use {"gisphm/vim-gitignore"}
        use {"lewis6991/gitsigns.nvim"}

        -- Utilities
        use {"sirver/ultisnips"}
        use {"mbbill/undotree"}
        use {"preservim/tagbar"}
        use {"tweekmonster/startuptime.vim"}
				-- use {"mhinz/vim-startify"}
        -- use {"unblevable/quick-scope"}
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

        -- Filetypes
        use {"xuhdev/vim-latex-live-preview", ft = "tex"}
        use {"iamcco/markdown-preview.nvim", ft = "markdown"}
        use {"octol/vim-cpp-enhanced-highlight"}

        -- Prettier
        use {"sbdchd/neoformat"}

        use {"tpope/vim-dispatch"}
        use {"vimwiki/vimwiki"}
        use {"voldikss/vim-floaterm"}
    end
)
