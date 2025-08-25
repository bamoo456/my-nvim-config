-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
  return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

-- configure nvim-tree
nvimtree.setup({
  -- change folder arrow icons
  renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "", -- arrow when folder is closed
          arrow_open = "", -- arrow when folder is open
        },
      },
    },
  },
  -- show hidden files by default
  filters = {
    dotfiles = false, -- show dotfiles (hidden files starting with .)
    git_ignored = false, -- show git ignored files
    git_clean = false, -- show git clean files
    custom = {}, -- remove any custom filters
  },
  -- disable window_picker for
  -- explorer to work well with
  -- window splits
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  -- custom key mappings
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)
    
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    
    -- custom mappings
    vim.keymap.set('n', '+', api.tree.change_root_to_node, opts('CD (Change Directory to Node)'))
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up (Change Directory to Parent)'))
  end,
  -- 	git = {
  -- 		ignore = false,
  -- 	},
})

-- open nvim-tree on setup

local function open_nvim_tree(data)
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
