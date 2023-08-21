-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>ch", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- bufferline
local opts = { noremap = true, silent = true }
keymap.set("n", "<C-[>", "<Cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<C-]>", "<Cmd>BufferNext<CR>", opts)

-- Re-order to previous/next
keymap.set("n", "<C-{>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap.set("n", "<C-}>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
keymap.set("n", "<C-1>", "<Cmd>BufferGoto 1<CR>", opts)
keymap.set("n", "<C-2>", "<Cmd>BufferGoto 2<CR>", opts)
keymap.set("n", "<C-3>", "<Cmd>BufferGoto 3<CR>", opts)
keymap.set("n", "<C-4>", "<Cmd>BufferGoto 4<CR>", opts)
keymap.set("n", "<C-5>", "<Cmd>BufferGoto 5<CR>", opts)
keymap.set("n", "<C-6>", "<Cmd>BufferGoto 6<CR>", opts)
keymap.set("n", "<C-7>", "<Cmd>BufferGoto 7<CR>", opts)
keymap.set("n", "<C-8>", "<Cmd>BufferGoto 8<CR>", opts)
keymap.set("n", "<C-9>", "<Cmd>BufferGoto 9<CR>", opts)
keymap.set("n", "<C-0>", "<Cmd>BufferLast<CR>", opts)
-- Close buffer
keymap.set("n", "<C-w>", "<Cmd>BufferClose<CR>", opts)
