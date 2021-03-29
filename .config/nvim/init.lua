-- generics
require('utils')

-- vim core settings
Reload.reload_module('general')
require('general')

-- vim plugins settings
Reload.reload_module('plugins')
require('plugins')

require('packer-setup')
