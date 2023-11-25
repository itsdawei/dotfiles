local M = {}

M.config = {
  document_highlight = true,
  code_lens_refresh = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
  },
  peek = {
    max_height = 15,
    max_width = 30,
    context = 10,
  },
  -- automatic_servers_installation = true,
  -- automatic_configuration = {
  --   ---@usage list of servers that the automatic installer will skip
  --   skipped_servers = skipped_servers,
  --   ---@usage list of filetypes that the automatic installer will skip
  --   skipped_filetypes = skipped_filetypes,
  -- },
  buffer_mappings = {
    normal_mode = {
      ["K"] = { vim.lsp.buf.hover, "Show hover" },
      ["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
      ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
      ["gr"] = { vim.lsp.buf.references, "Goto references" },
      ["gI"] = { vim.lsp.buf.implementation, "Goto Implementation" },
      ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
      ["gp"] = {
        function()
          require("lvim.lsp.peek").Peek "definition"
        end,
        "Peek definition",
      },
      ["gl"] = {
        function()
          local config = M.config.diagnostics.float
          config.scope = "line"
          vim.diagnostic.open_float(0, config)
        end,
        "Show line diagnostics",
      },
    },
    insert_mode = {},
    visual_mode = {},
  },
  null_ls = {
    setup = {},
    config = {},
  },
}

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return require("cmp_nvim_lsp").default_capabilities(capabilities)
  -- return require("cmp_nvim_lsp").default_capabilities()
end

function M.on_attach(client, bufnr)
  -- Add buffer key mappings
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(M.config.buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

function M.server_setup(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {
    on_attach = M.on_attach,
    capabilities = M.capabilities(),
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  require("lspconfig")[server].setup(config)
end

return M
