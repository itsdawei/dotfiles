local M = {}

local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")

local config = {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.90,
      height = 0.85,
      preview_cutoff = 120,
      prompt_position = "bottom",
      horizontal = {
        preview_width = function(_, cols, _)
          return math.floor(cols * 0.6)
        end,
      },
      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default + actions.center,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
    file_ignore_patterns = {},
    path_display = { shorten = 5 },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      --@usage don't include the filename in the search results
      only_sort_text = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
  file_previewer = previewers.vim_buffer_cat.new,
  grep_previewer = previewers.vim_buffer_vimgrep.new,
  qflist_previewer = previewers.vim_buffer_qflist.new,
  file_sorter = sorters.get_fuzzy_file,
  generic_sorter = sorters.get_generic_fuzzy_sorter,
}

function M.setup()
  require("telescope").setup(config)
  require("telescope").load_extension("fzf")
end

return M
