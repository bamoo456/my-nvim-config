-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- Workaround for Neovim 0.11.x treesitter async parse bug (#31777):
-- Async parse callback captures window ID that may become invalid before the
-- callback fires (e.g., opening file from NvimTree). Force synchronous parsing
-- to avoid the race condition.
vim.g._ts_force_sync_parsing = true

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- ensure these language parsers are installed
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "markdown",
    "markdown_inline",
    "svelte",
    "graphql",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "java", -- Add Java parser for better indentation
  },
  -- auto install above language parsers
  auto_install = true,
})
