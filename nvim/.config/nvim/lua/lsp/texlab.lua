M = {}

function M.setup()
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_view_method = "skim"
  vim.g.vimtex_view_skim_activate = 1
  vim.g.vimtex_view_skim_reading_bar = 0

  local latexmk_args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" }
  vim.g.tex_flavor = "latex"
  vim.g.vimtex_fold_enabled = 0
  vim.g.vimtex_quickfix_ignore_filters = {}
  vim.cmd([[
        augroup vimtex_event_1
            au!
            au User VimtexEventQuit     call vimtex#compiler#clean(0)
            au User VimtexEventInitPost call vimtex#compiler#compile()
        augroup END
    ]])
  local tex_preview_settings = {}
  local forward_search_executable = "/Applications/Skim.app/Contents/SharedSupport/displayline"

  -- local sumatrapdf_args = { "-reuse-instance", "%p", "-forward-search", "%f", "%l" }
  -- local evince_args = { "-f", "%l", "%p", '"code -g %f:%l"' }
  -- local okular_args = { "--unique", "file:%p#src:%l%f" }
  -- local zathura_args = { "--synctex-forward", "%l:1:%f", "%p" }
  -- local qpdfview_args = { "--unique", "%p#src:%f:%l:1" }
  local skim_args = { "%l", "%p", "%f" }
  tex_preview_settings = skim_args

  local opts = {
    setup = {
      cmd = { vim.fn.stdpath("data") .. "/lsp_servers/texlab" },
      filetypes = { "tex", "bib" },
      settings = {
        texlab = {
          auxDirectory = nil,
          bibtexFormatter = "texlab",
          build = {
            executable = "latexmk",
            args = latexmk_args,
            on_save = false,
            forward_search_after = false,
          },
          chktex = {
            on_open_and_save = false,
            on_edit = false,
          },
          forward_search = {
            executable = nil,
            args = {},
          },
          latexindent = {
            ["local"] = nil,
            modify_line_breaks = false,
          },
          linters = { "chktex" },
          auto_save = false,
          ignore_errors = {},
          diagnosticsDelay = 300,
          formatterLineLength = 120,
          forwardSearch = {
            args = tex_preview_settings,
            executable = forward_search_executable,
          },
          latexFormatter = "latexindent",
        },
      },
    },
  }

  require("lspconfig")["texlab"].setup(opts)
end

return M
