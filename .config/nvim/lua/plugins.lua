local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath('data') .. '/site/pack/packer/opt/'

    local plugin_path = plugin_prefix .. plugin .. '/'
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then vim.cmd('packadd ' .. plugin) end
    return ok, err, code
end

local function source_plugins()
    -- require_plugin('ultisnips')
    require_plugin('nvim-dap')

    require_plugin('vim-fugitive')
    require_plugin('floaterm')
    require_plugin('undotree')

    -- Color
    require_plugin('oceanic-material')
    require_plugin('gruvbox-material')
    require_plugin('gruvbox')
    require_plugin('nord-vim')
    require_plugin('onedark.vim')
    require_plugin('nvim-colorizer.lua')

    require('lv-symbols-outline')
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- TODO refactor all of this (for now it works, but yes I know it could be wrapped in a simpler function)
    use {'neovim/nvim-lspconfig'}
    use {'glepnir/lspsaga.nvim', cmd = 'Lspsaga', requires = {'neovim/nvim-lspconfig'}}
    use {
        'kabouzeid/nvim-lspinstall',
        cmd = 'LspInstall',
        config = function()
            require('lv-lspinstall')
        end
    }

    use {'simrat39/symbols-outline.nvim'}

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        module = {'plenary.nvim', 'popup.nvim'},
        config = function()
            require('lv-telescope')
        end,
        requires = {
            {'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzy-native.nvim'},
            {'nvim-telescope/telescope-project.nvim'}, {'nvim-telescope/telescope-media-files.nvim'}
        }
    }

    use {
        'folke/trouble.nvim',
        cmd = {'Trouble', 'TroubleClose', 'TroubleToggle', 'TroubleRefresh'},
        ft = 'dashboard',
        event = {'BufEnter'},
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- Debugging
    use {'mfussenegger/nvim-dap', opt = true}

    -- Autocomplete
    use {
        'hrsh7th/nvim-compe',
        event = 'InsertEnter',
        config = function()
            require('lv-compe')
        end
    }
    use {'hrsh7th/vim-vsnip', after = 'nvim-compe'}
    use {'rafamadriz/friendly-snippets', after = 'nvim-compe'}

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {
        'windwp/nvim-ts-autotag',
        ft = {'html', 'javascript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue'},
        config = function()
            require('nvim-ts-autotag').setup()
        end
    }
    use {'andymass/vim-matchup', keys = '%'}

    -- Explorer
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = {'NvimTreeToggle', 'NvimTreeRefresh', 'NvimTreeFindFile'},
        event = {'BufEnter'},
        config = function()
            require('lv-nvimtree')
        end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }
    use {'ahmedkhalf/lsp-rooter.nvim', after = 'nvim-tree.lua'} -- with this nvim-tree will follow you

    -- TODO remove when open on dir is supported by nvimtree
    use {
        'kevinhwang91/rnvimr',
        config = function()
            require('lv-rnvimr')
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
        config = function()
            require('lv-gitsigns')
        end
    }
    use {
        'f-person/git-blame.nvim',
        cmd = 'GitBlameToggle',
        config = function()
            require('lv-gitblame')
        end
    }
    use {
        'folke/which-key.nvim',
        event = {'BufEnter', 'BufReadPost'},
        ft = {'dashboard'},
        config = function()
            require('lv-which-key')
        end
    }
    use {
        'ChristianChiarulli/dashboard-nvim',
        event = 'BufEnter',
        config = function()
            require('lv-dashboard')
        end
    }
    use {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('lv-autopairs')
        end,
        requires = {'nvim-treesitter/nvim-treesitter'}
    }
    use {'kevinhwang91/nvim-bqf', event = 'QuickFixCmdPre'}

    use {'tpope/vim-fugitive', opt = true}
    use {'rhysd/git-messenger.vim', opt = true}

    -- Comments
    use {
        'terrortylor/nvim-comment',
        cmd = 'CommentToggle',
        keys = 'gcc',
        config = function()
            require('lv-comment')
        end
    }
    use {'JoosepAlviste/nvim-ts-context-commentstring', event = 'BufReadPost', requires = 'nvim-treesitter'}

    -- Utilities
    use {
        'numtostr/FTerm.nvim',
        config = function()
            require('FTerm').setup()
        end
    }
    use {'mbbill/undotree', opt = true}

    -- Zen Mode
    use {
        'Pocco81/TrueZen.nvim',
        cmd = {'TZMinimalist', 'TZFocus', 'TZAtaraxis'},
        config = function()
            require('lv-zen')
        end
    }

    -- Color
    use {
        'christianchiarulli/nvcode-color-schemes.vim',
        event = 'BufEnter',
        config = function()
            require('colorscheme')
        end
    }
    use {'norcalli/nvim-colorizer.lua', opt = true}
    use {'glepnir/oceanic-material', opt = true}
    use {'sainnhe/gruvbox-material', opt = true}
    use {'gruvbox-community/gruvbox', opt = true}
    use {'arcticicestudio/nord-vim', opt = true}
    use {'joshdick/onedark.vim', opt = true}

    -- Status Line and Bufferline
    use {
        'glepnir/galaxyline.nvim',
        event = 'BufEnter',
        config = function()
            require('lv-galaxyline')
        end
    }

    -- Cheat Sheet
    use {'RishabhRD/popfix', opt = true}
    use {'RishabhRD/nvim-cheat.sh', opt = true}

    -- Markdown
    use {
        'iamcco/markdown-preview.nvim',
        run = 'call mkdp#util#install()', -- use this line if the above doesn't work for you
        ft = 'markdown'
    }

    -- Tmux
    use {'christoomey/vim-tmux-navigator'}

    source_plugins()
end)
