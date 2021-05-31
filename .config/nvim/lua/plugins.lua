local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

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

local function source_plugins()
    require_plugin("nvim-lspconfig")
    require_plugin("lspsaga.nvim")
    require_plugin("nvim-lspinstall")
    require_plugin("nvim-compe")
    require_plugin("vim-vsnip")
    -- require_plugin("ultisnips")
    require_plugin("friendly-snippets")
    require_plugin("nvim-treesitter")
    require_plugin("nvim-tree.lua")
    require_plugin("gitsigns.nvim")
    require_plugin("vim-which-key")
    require_plugin("dashboard-nvim")
    require_plugin("nvim-autopairs")
    require_plugin("nvim-comment")
    require_plugin("nvim-bqf")
    require_plugin("nvim-web-devicons")
    require_plugin("vim-devicons")
    require_plugin("galaxyline.nvim")

    require_plugin("vim-fugitive")
    require_plugin("indent-blankline.nvim")
    require_plugin("floaterm")
    require_plugin("undotree")

    require_plugin("goyo.vim")
    require_plugin("limelight.vim")

    -- Color
    require_plugin("oceanic-material")
    require_plugin("gruvbox-material")
    require_plugin("gruvbox")
    require_plugin("nord-vim")
    require_plugin("onedark.vim")
    require_plugin("nvim-colorizer.lua")

end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {"neovim/nvim-lspconfig", opt = true}
    use {"glepnir/lspsaga.nvim", opt = true}
    use {"kabouzeid/nvim-lspinstall", opt = true}

    -- Telescope
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    use {"nvim-telescope/telescope.nvim"}
    use {'nvim-telescope/telescope-symbols.nvim'}
    use {'nvim-telescope/telescope-fzy-native.nvim'}
    use {'nvim-telescope/telescope-media-files.nvim'}

    -- Debugging
    use {'puremourning/vimspector', opt = true}
    use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}, opt = true}
    use {'szw/vim-maximizer', opt = true}

    -- Git
    use {'tpope/vim-fugitive', opt = true}
    use {"lewis6991/gitsigns.nvim", opt = true}
    use {'rhysd/git-messenger.vim', opt = true}
    use {'gisphm/vim-gitignore', opt = true}

    -- Autocomplete
    use {"hrsh7th/nvim-compe", opt = true}
    use {'sirver/ultisnips', opt = true}
    use {"hrsh7th/vim-vsnip", opt = true}
    use {"rafamadriz/friendly-snippets", opt = true}

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}

    -- Explorer
    use "kyazdani42/nvim-tree.lua"
    -- TODO remove when open on dir is supported by nvimtree
    use "kevinhwang91/rnvimr"

    -- Utilities
    use {'voldikss/vim-floaterm', opt = true}
    use {'lukas-reineke/indent-blankline.nvim', opt = true, branch = 'lua'}
    use {"liuchengxu/vim-which-key", opt = true}
    use {"ChristianChiarulli/dashboard-nvim", opt = true}
    use {"windwp/nvim-autopairs", opt = true}
    use {"terrortylor/nvim-comment", opt = true}
    use {"kevinhwang91/nvim-bqf", opt = true}
    use {'mbbill/undotree', opt = true}

    -- Goyo
    use {'junegunn/goyo.vim', opt = true}
    use {'junegunn/limelight.vim', opt = true}

    -- Color
    use {'norcalli/nvim-colorizer.lua', opt = true}
    use {'glepnir/oceanic-material', opt = true}
    use {'sainnhe/gruvbox-material', opt = true}
    use {'gruvbox-community/gruvbox', opt = true}
    use {'arcticicestudio/nord-vim', opt = true}
    use {'joshdick/onedark.vim', opt = true}

    -- Icons
    use {'ryanoasis/vim-devicons', opt = true}
    use {"kyazdani42/nvim-web-devicons", opt = true}

    -- Status Line and Bufferline
    use {"glepnir/galaxyline.nvim", opt = true}
    use {"romgrk/barbar.nvim", opt = true}

    -- Cheat Sheet
    use {'RishabhRD/popfix', opt = true}
    use {'RishabhRD/nvim-cheat.sh', opt = true}

    -- Markdown
    use {'iamcco/markdown-preview.nvim', ft = 'markdown', run = ':call mkdp#util#install()'}

    -- Tmux
    use {'christoomey/vim-tmux-navigator'}

    source_plugins()
end)
