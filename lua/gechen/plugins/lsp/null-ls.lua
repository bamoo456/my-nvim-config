-- import none-ls (null-ls compat) safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

-- for conciseness
local formatting = null_ls.builtins and null_ls.builtins.formatting or nil -- to setup formatters
local diagnostics = null_ls.builtins and null_ls.builtins.diagnostics or nil -- to setup linters

-- try to load eslint_d from none-ls-extras if available
local eslint_source = nil
local ok_extras, eslintd = pcall(require, "none-ls.diagnostics.eslint_d")
if ok_extras and eslintd then
  eslint_source = eslintd
elseif diagnostics then
  eslint_source = diagnostics.eslint_d or diagnostics.eslint
end

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
local sources = {}
if formatting and formatting.prettier then table.insert(sources, formatting.prettier) end
if formatting and formatting.stylua then table.insert(sources, formatting.stylua) end
-- Add Java formatter only if available (install manually with :MasonInstall google-java-format)
if formatting and formatting.google_java_format then 
  table.insert(sources, formatting.google_java_format) 
end
if eslint_source then
  table.insert(sources, eslint_source.with({
    condition = function(utils)
      return utils.root_has_file(".eslintrc.js")
    end,
  }))
end

null_ls.setup({
  sources = sources,
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method and current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- Skip auto-formatting for Java files
          local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
          if filetype == "java" then
            return
          end
          
          vim.lsp.buf.format({
            filter = function(client)
              return client.name == "null-ls" or client.name == "none-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
