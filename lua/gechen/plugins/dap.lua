-- Minimal nvim-dap setup and keymaps
local ok, dap = pcall(require, "dap")
if not ok then
  return
end

-- Keymaps (conservative to avoid collisions)
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<F5>", function() dap.continue() end, opts)
vim.keymap.set("n", "<F9>", function() dap.toggle_breakpoint() end, opts)
vim.keymap.set("n", "<F10>", function() dap.step_over() end, opts)
vim.keymap.set("n", "<F11>", function() dap.step_into() end, opts)
vim.keymap.set("n", "<S-F11>", function() dap.step_out() end, opts)
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, opts)
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, opts)

-- No adapter definitions here; jdtls provides Java DAP config dynamically

