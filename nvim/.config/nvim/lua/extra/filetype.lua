local M = {}

function M.setup()
  require("filetype").setup {
    overrides = {
      literal = {
        ["kitty.conf"] = "kitty",
        [".gitignore"] = "conf",
      },
      complex = {
        [".clang*"] = "yaml",
        [".*%.env.*"] = "sh",
        [".*ignore"] = "conf",
      },
      extensions = {
        eslintrc = "json",
        prettierrc = "json",
        mdx = "markdown",
      },
    },
  }
end

return M
