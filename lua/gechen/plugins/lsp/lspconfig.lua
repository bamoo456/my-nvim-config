-- LSP configuration using Neovim 0.11+ native vim.lsp.config / vim.lsp.enable API

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local keymap = vim.keymap -- for conciseness

-- Set up keybinds when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }

    keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts)
    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    keymap.set("n", "gI", "<cmd>Lspsaga incoming_calls<CR>", opts)
    keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
    keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
  end,
})

-- Autocompletion capabilities (shared by all servers)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Diagnostic signs
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "ﴞ ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})

-- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
vim.lsp.config("html", {
  capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

vim.lsp.config("cssls", {
  capabilities = capabilities,
})

vim.lsp.config("tailwindcss", {
  capabilities = capabilities,
})

vim.lsp.config("emmet_ls", {
  capabilities = capabilities,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

-- Enable all configured servers (jdtls excluded — handled by nvim-jdtls plugin)
vim.lsp.enable({ "html", "ts_ls", "cssls", "tailwindcss", "emmet_ls", "lua_ls" })
