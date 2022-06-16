local opts = {
  root_dir = function(fname)
    local util = require "lspconfig.util"
    local root_files = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "manage.py",
      "pyrightconfig.json",
    }
    return util.root_pattern(unpack(root_files))(fname) or util.root_pattern ".git"(fname) or util.path.dirname(fname)
  end,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    pylsp = {
      plugins = {
        jedi_completion = {enabled = true},
        jedi_hover = {enabled = true},
        jedi_references = {enabled = true},
        jedi_signature_help = {enabled = true},
        jedi_symbols = {enabled = true, all_scopes = true},
        pycodestyle = {enabled = false},
        pyflakes = {enabled = false},
        isort = {enabled = true},
        yapf = {enabled = true},
        pylint = {enabled = true}
      }
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
  single_file_support = true,
}

local servers = require "nvim-lsp-installer.servers"
local server_available, requested_server = servers.get_server "pylsp"
if server_available then
  opts.cmd_env = requested_server:get_default_options().cmd_env
end

require("lvim.lsp.manager").setup("pylsp", opts)

vim.cmd [[setlocal shiftwidth=4]]
