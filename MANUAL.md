# Neovim Configuration Manual

## Quick Start Guide

**Leader Key**: `<Space>` (all leader commands start with Space)

## Core Navigation

### Window Management
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make split windows equal size
- `<leader>sx` - Close current split window
- `<leader>sm` - Toggle maximize current window (vim-maximizer)
- `Ctrl-h/j/k/l` - Navigate between splits (vim-tmux-navigator)

### Tab Management
- `<leader>to` - Open new tab
- `<leader>tx` - Close current tab
- `<leader>tn` - Go to next tab
- `<leader>tp` - Go to previous tab

### Buffer Navigation (Barbar)
- `Ctrl-[` - Previous buffer
- `Ctrl-]` - Next buffer
- `Ctrl-{` - Move buffer left
- `Ctrl-}` - Move buffer right
- `Ctrl-1` to `Ctrl-9` - Go to buffer 1-9
- `Ctrl-0` - Go to last buffer
- `Ctrl-w` - Close current buffer

## File Management

### NvimTree (File Explorer)
- `<leader>e` - Toggle file explorer
- **Inside NvimTree:**
  - `Enter` - Open file/folder
  - `v` - Open in vertical split
  - `h` - Open in horizontal split
  - `t` - Open in new tab
  - `a` - Create new file/folder (end with `/` for folder)
  - `d` - Delete file/folder
  - `r` - Rename file/folder
  - `x` - Cut file/folder
  - `c` - Copy file/folder
  - `p` - Paste file/folder
  - `y` - Copy name
  - `Y` - Copy relative path
  - `gy` - Copy absolute path
  - `I` - Toggle hidden files
  - `R` - Refresh tree
  - `?` - Show help

### Telescope (Fuzzy Finder)
- `<leader>ff` - Find files (respects .gitignore)
- `<leader>fg` - Live grep (search text in files)
- `<leader>fc` - Find string under cursor
- `<leader>fb` - Browse open buffers
- `<leader>fh` - Browse help tags

**Inside Telescope:**
- `Ctrl-j/k` - Navigate results
- `Ctrl-q` - Send results to quickfix list
- `Enter` - Open selection
- `Ctrl-v` - Open in vertical split
- `Ctrl-x` - Open in horizontal split
- `Ctrl-t` - Open in new tab

### Git Integration (Telescope + Fugitive)
- `<leader>gc` - Browse git commits
- `<leader>gfc` - Browse commits for current file
- `<leader>gb` - Browse git branches
- `<leader>gs` - Git status with diff preview

**Gitsigns indicators:**
- Green line on left - Added lines
- Blue line on left - Changed lines
- Red line on left - Deleted lines

## Code Editing

### Text Manipulation
- `jk` - Exit insert mode (alternative to ESC)
- `x` - Delete character without copying to register
- `<leader>+` - Increment number under cursor
- `<leader>-` - Decrement number under cursor
- `<leader>ch` - Clear search highlights

### Surround (vim-surround)
- `ys{motion}{char}` - Add surrounding
  - Example: `ysiw"` - Surround word with quotes
  - Example: `ys$)` - Surround to end of line with parentheses
- `ds{char}` - Delete surrounding
  - Example: `ds"` - Delete surrounding quotes
- `cs{old}{new}` - Change surrounding
  - Example: `cs"'` - Change quotes to single quotes

### Comments (Comment.nvim)
- `gcc` - Toggle comment for current line
- `gc{motion}` - Toggle comment for motion
  - Example: `gcap` - Comment a paragraph
  - Example: `gc3j` - Comment 3 lines down
- **Visual mode:** Select lines then `gc` to toggle comments

### Multiple Cursors (vim-visual-multi)
- `Ctrl-n` - Select word under cursor and find next
- `Ctrl-Shift-Down` - Add cursor down
- `Ctrl-Shift-Up` - Add cursor up
- `Ctrl-Down/Up` - Create cursors vertically
- **In VM mode:**
  - `n/N` - Find next/previous occurrence
  - `q` - Skip current and find next
  - `Q` - Remove current cursor
  - `Tab` - Switch between cursor and extend mode
  - `Esc` - Exit VM mode

### Replace with Register
- `gr{motion}` - Replace motion with register contents
  - Example: `griw` - Replace inner word with yanked text
  - Example: `gr$` - Replace to end of line

### Auto-pairs & Auto-tags
- Automatically closes brackets, quotes, and HTML tags
- Type opening bracket/quote - closing is added automatically
- HTML/JSX: Type opening tag - closing tag is added automatically

## Language Server Protocol (LSP)

### LSP Keybindings (via LSPSaga)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Show references
- `K` - Show hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>d` - Show line diagnostics
- `[d` - Go to previous diagnostic
- `]d` - Go to next diagnostic
- `<leader>rs` - Restart LSP server

### Mason (LSP Manager)
**Commands:**
- `:Mason` - Open Mason UI
- `:MasonInstall <server>` - Install language server
- `:MasonUninstall <server>` - Uninstall language server
- `:MasonUpdate` - Update installed servers
- `:LspInfo` - Show active LSP clients

**Pre-configured servers:**
- TypeScript/JavaScript: `tsserver`, `eslint_d`, `prettier`
- HTML/CSS: `html`, `cssls`, `tailwindcss`, `emmet_ls`
- Lua: `lua_ls`, `stylua`

## Autocompletion (nvim-cmp)

**In Insert Mode:**
- `Ctrl-Space` - Trigger completion manually
- `Ctrl-j/k` - Navigate completion items
- `Tab` - Select next item
- `Shift-Tab` - Select previous item
- `Enter` - Confirm selection
- `Ctrl-e` - Close completion menu
- `Ctrl-f/b` - Scroll documentation window

**Snippet Navigation:**
- `Tab` - Jump to next snippet placeholder
- `Shift-Tab` - Jump to previous placeholder

## Treesitter

Provides intelligent syntax highlighting and code understanding.

**Features:**
- Enhanced syntax highlighting
- Incremental selection
- Code folding
- Indentation

**Keybindings:**
- `zc` - Close fold
- `zo` - Open fold
- `za` - Toggle fold
- `zR` - Open all folds
- `zM` - Close all folds

## GitHub Copilot

**Usage:**
- `Tab` - Accept suggestion (in insert mode)
- `Alt-]` - Next suggestion
- `Alt-[` - Previous suggestion
- `Alt-\` - Trigger suggestion manually
- `Ctrl-Enter` - Open Copilot panel

**Commands:**
- `:Copilot enable` - Enable Copilot
- `:Copilot disable` - Disable Copilot
- `:Copilot status` - Check status
- `:Copilot panel` - Open suggestion panel

## Plugin Management (Packer)

**Commands:**
- `:PackerSync` - Install/Update/Clean plugins
- `:PackerStatus` - Show plugin status
- `:PackerCompile` - Compile configuration
- `:PackerClean` - Remove unused plugins

**Auto-sync:** Saving `lua/gechen/plugins-setup.lua` automatically runs PackerSync

## Lualine (Status Line)

Shows:
- Current mode (Normal/Insert/Visual/etc.)
- Git branch and changes
- File name and status
- Cursor position
- File encoding and format
- Active LSP clients

## Tips & Tricks

### Productivity Boosters
1. Use `<leader>ff` frequently for quick file navigation
2. Master `gcc` for quick commenting/uncommenting
3. Use `Ctrl-n` for quick multi-cursor editing
4. Leverage LSP's `K` for quick documentation lookup
5. Use `<leader>fg` for project-wide search

### Terminal Integration
- If using tmux, vim-tmux-navigator allows seamless pane navigation
- Use `Ctrl-h/j/k/l` to move between vim splits and tmux panes

### Customization
- Personal keymaps: Edit `lua/gechen/core/keymaps.lua`
- Add plugins: Edit `lua/gechen/plugins-setup.lua`
- LSP settings: Edit `lua/gechen/plugins/lsp/lspconfig.lua`
- Options: Edit `lua/gechen/core/options.lua`

### Troubleshooting
1. **Plugins not loading:** Delete `plugin/packer_compiled.lua` and run `:PackerSync`
2. **LSP not working:** Run `:LspInfo` to check status, `:Mason` to install servers
3. **Keybinding conflicts:** Check `:map <key>` to see what's bound to a key
4. **Visual-Multi keys not working:** Terminal may not support Ctrl-Shift combinations, consider remapping in `plugins-setup.lua`

## Quick Reference Card

### Most Used Commands
| Command | Action |
|---------|--------|
| `<Space>ff` | Find files |
| `<Space>fg` | Search text |
| `<Space>e` | File explorer |
| `gcc` | Toggle comment |
| `gd` | Go to definition |
| `K` | Show documentation |
| `<Space>ca` | Code actions |
| `Ctrl-n` | Multi-cursor |
| `<Space>sv` | Split vertical |
| `Ctrl-[/]` | Switch buffers |

### Modes
- **Normal**: Navigation and commands
- **Insert**: Text editing (`i`, `a`, `o`)
- **Visual**: Text selection (`v`, `V`, `Ctrl-v`)
- **Command**: Ex commands (`:`)