local execute = vim.api.nvim_command
local fn = vim.fn

-- INSTALL packer {{{
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    execute "packadd packer.nvim"
end
-- }}}

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then vim.cmd("packadd " .. plugin) end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
    -- packer
    use {'wbthomason/packer.nvim'}

    -- LSP
    use {'neovim/nvim-lspconfig'}
    use {'kabouzeid/nvim-lspinstall'}
    use {'hrsh7th/nvim-compe'}

    -- Debugging
    use {'puremourning/vimspector'}
    use {
        'tpope/vim-dispatch',
        opt = true,
        cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
    }
    use {'szw/vim-maximizer'}

    -- Explorer
    -- use {'preservim/nerdtree'}
    -- use {'Xuyuanp/nerdtree-git-plugin'}
    use {'kyazdani42/nvim-tree.lua'}

    -- Editor UI
    use {'glepnir/galaxyline.nvim'}
    use {'norcalli/nvim-colorizer.lua'}
    use {'ryanoasis/vim-devicons'}
    use {'kyazdani42/nvim-web-devicons'}

    -- Tree Shitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}

    -- Telescope
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}
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

    -- Colorscheme
    use {'glepnir/oceanic-material'}
    use {'sainnhe/gruvbox-material'}
    use {'gruvbox-community/gruvbox'}
    use {'arcticicestudio/nord-vim'}
    use {'joshdick/onedark.vim'}
end)
