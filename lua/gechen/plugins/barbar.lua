-- import barbar plugin safely
local setup, barbar = pcall(require, "barbar")
if not setup then
	return
end

-- enable barbar
barbar.setup({})

-- Explicitly unmap any default barbar mappings that might conflict with Esc
-- This ensures no default mappings interfere with our custom ones
pcall(vim.keymap.del, 'n', '<C-[>')
pcall(vim.keymap.del, 'n', '<C-]>')
