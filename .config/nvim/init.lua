require('packer-setup')

-- generics
require('utils')

-- vim core settings
Reload.reload_module('settings')
require('settings')

-- vim plugins settings
Reload.reload_module('plugins')
require('plugins')
