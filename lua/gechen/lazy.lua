-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorscheme
  {
    "bluz71/vim-nightfly-guicolors",
    priority = 1000,
    lazy = false,
  },

  -- Essentials
  { "nvim-lua/plenary.nvim", lazy = false },
  { "christoomey/vim-tmux-navigator", lazy = false },
  { "szw/vim-maximizer", lazy = false },
  { "tpope/vim-surround", lazy = false },
  { "inkarkat/vim-ReplaceWithRegister", lazy = false },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("gechen.plugins.comment")
    end,
    lazy = false,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("gechen.plugins.nvim-tree")
    end,
    lazy = false,
  },
  { "nvim-tree/nvim-web-devicons", lazy = false },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("gechen.plugins.lualine")
    end,
    lazy = false,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    config = function()
      require("gechen.plugins.telescope")
    end,
  },

  -- Completion and snippets
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
      { "saadparwaiz1/cmp_luasnip" },
      { "rafamadriz/friendly-snippets" },
      { "onsails/lspkind.nvim" },
    },
    config = function()
      require("gechen.plugins.nvim-cmp")
    end,
  },

  -- LSP and related
  {
    "williamboman/mason.nvim",
    dependencies = {
      { "williamboman/mason-lspconfig.nvim" },
      { "jayp0521/mason-null-ls.nvim" },
    },
    config = function()
      require("gechen.plugins.lsp.mason")
    end,
    lazy = false,
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("gechen.plugins.lsp.lspsaga")
    end,
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      require("gechen.plugins.lsp.lspconfig")
    end,
    lazy = false,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("gechen.plugins.lsp.jdtls")
    end,
  },
  -- Debug Adapter Protocol (required for running/debugging Java tests)
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      require("gechen.plugins.dap")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    config = function()
      require("gechen.plugins.lsp.null-ls")
    end,
    lazy = false,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "windwp/nvim-ts-autotag" },
    config = function()
      require("gechen.plugins.treesitter")
    end,
  },

  -- Multicursor
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_maps = {
        ["Add Cursor Down"] = "<C-S-Down>",
        ["Add Cursor Up"] = "<C-S-Up>",
      }
    end,
    lazy = false,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("gechen.plugins.autopairs")
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPre",
    config = function()
      require("gechen.plugins.gitsigns")
    end,
  },
  { "tpope/vim-fugitive", lazy = false },
  
  -- Advanced git history and diff viewing
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
      { "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gdl", function()
          local line = vim.fn.line('.')
          vim.cmd('DiffviewFileHistory % --range=' .. line .. ':' .. line)
        end, desc = "Line history" },
    },
    config = function()
      require("diffview").setup()
    end,
  },
  
  -- Git line messenger
  {
    "rhysd/git-messenger.vim",
    keys = {
      { "<leader>gm", "<Plug>(git-messenger)", desc = "Git messenger" },
    },
  },

  -- Tabs (barbar)
  {
    "romgrk/barbar.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("gechen.plugins.barbar")
    end,
    lazy = false,
  },

  -- Copilot
  { "github/copilot.vim", lazy = false },

  -- Claude Code (Neovim integration for Anthropic Claude Code CLI)
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "ClaudeCode",
      "ClaudeCodeContinue",
      "ClaudeCodeResume",
      "ClaudeCodeVerbose",
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
      { "<C-,>", "<cmd>ClaudeCode<CR>", mode = { "n", "t" }, desc = "Toggle Claude Code" },
      { "<leader>cC", function()
          vim.cmd("ClaudeCodeContinue")
        end, desc = "Claude Code Continue" },
      { "<leader>cV", function()
          vim.cmd("ClaudeCodeVerbose")
        end, desc = "Claude Code Verbose" },
    },
    config = function()
      require("gechen.plugins.claude-code")
    end,
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { 
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons" 
    },
    ft = { "markdown" },
    config = function()
      require("gechen.plugins.render-markdown")
    end,
  },

  -- Yank for Claude
  {
    "wasabeef/yank-for-claude.nvim",
    config = function()
      require("gechen.plugins.yank-for-claude")
    end,
    keys = {
      -- Reference only
      { "<leader>y", function() require("yank-for-claude").yank_visual() end, mode = "v", desc = "Yank for Claude" },
      { "<leader>y", function() require("yank-for-claude").yank_line() end, mode = "n", desc = "Yank line for Claude" },

      -- Reference + Code
      { "<leader>Y", function() require("yank-for-claude").yank_visual_with_content() end, mode = "v", desc = "Yank with content" },
      { "<leader>Y", function() require("yank-for-claude").yank_line_with_content() end, mode = "n", desc = "Yank line with content" },
    },
  },
})


