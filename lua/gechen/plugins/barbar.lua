-- import barbar plugin safely
local setup, barbar = pcall(require, "barbar")
if not setup then
	return
end

-- enable barbar
barbar.setup({})
