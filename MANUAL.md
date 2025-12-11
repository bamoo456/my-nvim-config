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
- `Ctrl-w w` - Cycle through all windows (including floats)
- `Ctrl-w c` - Close current window

### Tab Management
- `<leader>to` - Open new tab
- `<leader>tx` - Close current tab
- `<leader>tn` - Go to next tab
- `<leader>tp` - Go to previous tab

### Buffer Navigation (Barbar)
- `Ctrl-Shift-[` - Previous buffer
- `Ctrl-Shift-]` - Next buffer
- `Ctrl-Tab` - Move buffer left
- `Ctrl-Shift-Tab` - Move buffer right
- `Ctrl-1` to `Ctrl-9` - Go to buffer 1-9
- `Ctrl-0` - Go to last buffer
- `Ctrl-w` - Close current buffer

## File Management

### NvimTree (File Explorer)
- `<leader>e` - Toggle file explorer
- `<leader>ef` - Find current file in tree and toggle
- **Inside NvimTree:**
  - `Enter` - Open file/folder
  - `+` - Enter folder completely (change root to selected folder)
  - `-` - Go back to parent folder (change root to parent)
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
  - `f` - Start live filter (search within tree)
  - `F` - Clear live filter
  - `s` - Search for node by name
  - `Ctrl-f` - Find file in tree
  - `?` - Show help

### Telescope (Fuzzy Finder)
- `<leader>ff` - Find files (shows hidden files and ignores .gitignore)
- `<leader>fg` - Live grep (search text in files)
- `<leader>fc` - Find string under cursor
- `<leader>fb` - Browse open buffers
- `<leader>fh` - Browse help tags

**File Filtering:**
- Automatically ignores Java build artifacts (`.class`, `.jar`, `.war`, `target/`)
- Shows hidden files (dotfiles) by default
- Shows files normally ignored by .gitignore (like `.env`)

**Inside Telescope:**
- `Ctrl-j/k` - Navigate results
- `Ctrl-q` - Send results to quickfix list
- `Enter` - Open selection
- `Ctrl-v` - Open in vertical split
- `Ctrl-x` - Open in horizontal split
- `Ctrl-t` - Open in new tab

### Git Integration (Telescope + Fugitive + Gitsigns)
- `<leader>gc` - Browse git commits
- `<leader>gfc` - Browse commits for current file
- `<leader>gb` - Browse git branches
- `<leader>gs` - Git status with diff preview

**Git Blame & History (for checking previous commit changes):**
- `<leader>gm` - **Git messenger** - Shows commit info for current line in popup (navigate with `o`/`O`)
- `<leader>gdl` - **Line history** - Visual diff history for current line (diffview)
- `<leader>gdh` - **File history** - Complete file history with visual diffs
- `<leader>gdo` - **Open diffview** - Compare current changes

**Gitsigns keymaps (when in git repo):**
- `<leader>hb` - Show detailed blame for current line
- `<leader>tb` - Toggle inline blame display for all lines
- `<leader>hp` - Preview current hunk changes
- `<leader>hs` - Stage current hunk
- `<leader>hr` - Reset current hunk
- `]c` - Jump to next git hunk
- `[c` - Jump to previous git hunk

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

**Navigation Commands:**
- `gf` - **Finder** (unified view) - Shows both definitions AND references in one window. Use when you want to see all related locations at once and choose where to go
- `gd` - **Go to definition** - Jumps directly to where symbol is defined (variable declaration, function body, class definition). Use when you know you want the definition
- `gD` - **Go to declaration** - Jumps to forward declaration (header files in C/C++, interface declarations). Use mainly in C/C++ or when you need the declaration vs definition
- `gi` - **Go to implementation** - Jumps to concrete implementation of interface/abstract method. Use when working with interfaces/abstract classes and need the actual implementation
- `gr` - **Show references** - Lists all places where symbol is used/called. Use when you want to see how/where something is being used across your codebase
- `gI` - **Incoming calls** - Shows what functions/methods call the current symbol. Use when debugging call chains or understanding code flow backwards

**Information & Actions:**
- `K` - **Show hover documentation** - Displays type info, documentation, parameter details. Use when you need quick info without navigating away
- `<leader>ca` - **Code actions** - Context-sensitive fixes/refactors (auto-import, quick fixes, generate code). Use when you see lightbulb icon or need automated fixes
- `<leader>rn` - **Rename symbol** - Renames symbol across entire project safely. Use when refactoring variable/function/class names

**Diagnostics (Errors/Warnings):**
- `<leader>d` - **Show line diagnostics** - Displays error/warning details for current line in popup. Use when you see red/yellow squiggles and need details
- `[d` - **Previous diagnostic** - Jump to previous error/warning in file. Use for navigating through issues
- `]d` - **Next diagnostic** - Jump to next error/warning in file. Use for navigating through issues

**Utility:**
- `<leader>rs` - **Restart LSP server** - Restarts language server when it's misbehaving. Use when autocomplete/diagnostics stop working

#### Finder (`gf`) actions
- `Enter` - Open selection in current window
- `s` - Open in vertical split
- `i` - Open in horizontal split
- `t` - Open in new tab
- `p` - Toggle preview
- `q` - Close finder

#### Closing LSP Float Panels
**When float panels get "stuck" open after clicking elsewhere:**

**Direct Close (from anywhere):**
- `Ctrl-w c` - Close current floating window (most reliable)
- `Ctrl-w q` - Quit current window (alternative to Ctrl-w c)
- `:close` - Close current window via command
- `:fclose!` - Force close all floating windows (nuclear option)

**Navigate-then-Close (when you can see the float):**
- `Ctrl-w w` → `q` - Navigate to float panel, then quit with 'q'
- `Ctrl-w w` → `Escape` - Navigate to float panel, then escape
- `Ctrl-w w` → `:q` - Navigate to float panel, then quit via command

**LSPSaga-specific (when focused on the float):**
- `q` - Quit LSPSaga finder/references window
- `Escape` - Exit most LSPSaga panels
- `Ctrl-c` - Cancel/close LSPSaga operations

**Tips:**
- **Best approach**: `Ctrl-w c` works from anywhere without navigation
- **If that fails**: Try `Ctrl-w q` or navigate with `Ctrl-w w` first
- **For multiple stuck windows**: Use `:fclose!` to close all at once
- Float panels should auto-close when switching focus, but sometimes get stuck

### Java Development (nvim-jdtls)

**Java-specific LSP features:**
- `<leader>jo` - Organize imports
- `<leader>jv` - Extract variable (normal/visual mode)
- `<leader>jc` - Extract constant (normal/visual mode)
- `<leader>jm` - Extract method (visual mode)
- `<leader>jt` - Run test class
- `<leader>jn` - Run nearest test method

#### Java Test/Debug (DAP)

One-time setup:
- Install test/debug bundles: `:MasonInstall java-debug-adapter java-test`

Run & Debug keys:
- `<leader>jn` — Run nearest test (uses DAP under the hood)
- `<leader>jt` — Run test class
- `<F9>` — Toggle breakpoint
- `<F5>` — Start/continue debug
- `<F10>` — Step over  •  `<F11>` — Step into  •  `<S-F11>` — Step out
- `<leader>db` — Toggle breakpoint  •  `<leader>dc` — Start/continue

**Java Project Requirements:**- Project must have one of: `.git`, `pom.xml`, `build.gradle`, `mvnw`, `gradlew`
- Java 8 runtime configured for project compilation
- Java 21 runtime used for JDTLS language server

**Features:**
- Automatic project detection (Maven, Gradle)
- Per-project workspace isolation
- Enhanced code completion with static imports
- Automatic import organization
- Code generation (toString, getters/setters)
- Refactoring support (extract variable/method/constant)
- Test running integration

#### Diagnostics & warnings (Java)
- `<leader>d` — Show diagnostics for item under cursor (warning/error popup)
- `<leader>D` — Show diagnostics for current line
- `[d` / `]d` — Previous/next diagnostic
- Open float manually: `:lua vim.diagnostic.open_float(0, { scope = "line" })`
- List diagnostics
  - Current buffer: `:Telescope diagnostics bufnr=0`
  - Workspace: `:Telescope diagnostics`
- Optional inline messages: `:lua vim.diagnostic.config({ virtual_text = true })`

Tip: To restart Java LSP, prefer `:JdtUpdateConfig` (not `:LspRestart`).

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
- Java: `jdtls` (via nvim-jdtls plugin)

### Auto-formatting Controls (null-ls)

**Format Toggle Commands:**
- `:FormatDisable` - Disable autoformat-on-save for current buffer
- `:FormatDisable!` - Disable autoformat-on-save globally (all buffers)
- `:FormatEnable` - Enable autoformat-on-save for current buffer
- `:FormatEnable!` - Enable autoformat-on-save globally (all buffers)
- `:FormatToggle` - Toggle autoformat-on-save for current buffer
- `:FormatToggle!` - Toggle autoformat-on-save globally (all buffers)

**Usage:**
- Auto-formatting is **enabled by default** for all supported files on save
- Java files are **automatically excluded** from auto-formatting (use `:JdtFormat` instead)
- Use buffer-level commands when you want to disable formatting for specific files
- Use global commands (with `!`) when you want to disable formatting for all files temporarily
- Settings persist only for the current Neovim session

**Supported formatters:**
- JavaScript/TypeScript/JSON/HTML/CSS: `prettier`
- Lua: `stylua`
- Java: Manual formatting via JDTLS (not auto-formatted on save)

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

## Claude Code AI Assistant

**Setup Required:**
1. Install Claude CLI: `brew install anthropic-ai/formulae/claude`
2. Authenticate: Run `claude` and follow login prompts
3. Alternative install: `npm install -g @anthropic-ai/claude-code`

**Keybindings:**
- `<leader>ac` - Toggle Claude Code terminal
- `Ctrl-,` - Toggle Claude Code (normal/terminal mode)
- `<leader>cC` - Continue last conversation
- `<leader>cV` - Verbose mode (full turn-by-turn output)

**Commands:**
- `:ClaudeCode` - Toggle Claude Code terminal
- `:ClaudeCodeContinue` - Resume most recent conversation
- `:ClaudeCodeResume` - Interactive conversation picker
- `:ClaudeCodeVerbose` - Enable verbose logging

**Inside Claude Terminal:**
- `Ctrl-h/j/k/l` - Navigate between windows
- `Ctrl-f/b` - Scroll page up/down (press `i` after to re-enter insert)
- `Ctrl-,` - Toggle terminal (same as opening)

**Features:**
- Auto-reloads files modified by Claude
- Sets working directory to git root automatically
- Detects file changes and shows notifications
- Terminal opens in bottom split by default (configurable to float)

**Tips:**
- Claude can read, edit, and create files in your project
- Ask Claude to explain code, fix bugs, or implement features
- Use continue mode to resume previous conversations
- Files are automatically refreshed when Claude modifies them

### Yank for Claude Integration

**Keybindings:**
- `<leader>y` - Yank current line (normal mode) or selection (visual mode) for Claude
- `<leader>Y` - Yank current line (normal mode) or selection (visual mode) with file content context

**Usage:**
- Use `<leader>y` to copy code snippets with proper formatting for Claude
- Use `<leader>Y` to include additional file context when sharing code
- Works in both normal mode (yanks current line) and visual mode (yanks selection)
- Automatically formats code with file path and line numbers for better Claude understanding

## Markdown Rendering (render-markdown.nvim)

**Automatic Features:**
- Enhanced markdown rendering in normal and command modes
- Only loads when opening `.md` files for optimal performance
- Renders automatically - no commands needed

**Visual Enhancements:**
- **Headings**: Beautiful icons (󰲡 󰲣 󰲥 󰲧 󰲩 󰲫) with colored backgrounds
- **Code blocks**: Language-specific highlighting with borders
- **Lists**: Styled bullets (● ○ ◆ ◇) for different nesting levels
- **Checkboxes**: Interactive-style rendering
  - `[ ]` → 󰄱 (unchecked)
  - `[x]` → 󰱒 (checked)
  - `[-]` → 󰥔 (todo/partial)
- **Tables**: Clean borders with proper alignment
- **Block quotes**: Visual indicator bars (▋)
- **Links**: Icons for hyperlinks (󰌹) and images (󰥶)

**Callouts Support:**
Special GitHub/Obsidian-style callouts are rendered with icons:
- `[!NOTE]` → 󰋽 Note
- `[!TIP]` → 󰌶 Tip
- `[!IMPORTANT]` → 󰅾 Important
- `[!WARNING]` → 󰀪 Warning
- `[!CAUTION]` → 󰳦 Caution
- `[!TODO]` → 󰗡 Todo
- `[!SUCCESS]` → 󰄬 Success
- `[!BUG]` → 󰨰 Bug
- `[!EXAMPLE]` → 󰉹 Example

**Anti-conceal Feature:**
- Raw markdown syntax appears when cursor is on that line
- Rendered view returns when cursor moves away
- Perfect balance between editing and reading

**Usage Tips:**
- Open any `.md` file to see enhanced rendering automatically
- Switch to insert mode to see raw markdown for editing
- All rendering respects your colorscheme
- Works seamlessly with existing markdown workflows

## Plugin Management (lazy.nvim)

**Commands:**
- `:Lazy` - Open Lazy UI
- `:Lazy sync` - Install/Update/Clean plugins
- `:Lazy install` - Install missing plugins
- `:Lazy update` - Update plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for updates
- `:Lazy log` - Show recent updates

**Configuration:** Edit `lua/gechen/lazy.lua` to add/modify plugins

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
1. **Plugins not loading:** Run `:Lazy sync` to install/update plugins
2. **LSP not working:** Run `:LspInfo` to check status, `:Mason` to install servers
3. **Java JDTLS issues:**
   - Ensure Java 21 is installed: `/Library/Java/JavaVirtualMachines/zulu-21.jdk/`
   - Check project has `pom.xml`, `build.gradle`, or `.git` in root
   - Run `:JdtUpdateConfig` to restart JDTLS (Java project)
   - Check `:LspLog` for error messages
   - Clear workspace: `rm -rf ~/.cache/jdtls-workspace/*`
   - Error: "`nvim-dap` must be installed to run and debug methods" → Run `:Lazy sync` and ensure `mfussenegger/nvim-dap` is installed; then restart Neovim
4. **Keybinding conflicts:** Check `:map <key>` to see what's bound to a key
5. **Visual-Multi keys not working:** Terminal may not support Ctrl-Shift combinations, consider remapping in `plugins-setup.lua`

## Quick Reference Card

### Most Used Commands
| Command | Action |
|---------|--------|
| `<Space>ff` | Find files |
| `<Space>fg` | Search text |
| `<Space>e` | File explorer |
| `<Space>ef` | Find current file in tree |
| `<Space>ac` | Claude Code AI |
| `<Space>y` | Yank for Claude |
| `<Space>Y` | Yank with context |
| `Ctrl-,` | Toggle Claude Code |
| `gcc` | Toggle comment |
| `gf` | LSP Finder (defs + refs) |
| `gI` | Incoming calls (callers) |
| `gr` | References (call sites) |
| `gd` | Go to definition |
| `K` | Show documentation |
| `<Space>ca` | Code actions |
| `<Space>jo` | Organize imports (Java) |
| `<Space>jv` | Extract variable (Java) |
| `Ctrl-n` | Multi-cursor |
| `<Space>sv` | Split vertical |
| `Ctrl-[/]` | Switch buffers |
| `Ctrl-w w` | Cycle through windows |
| `Ctrl-w c` / `Ctrl-w q` | Close floating window |

### Modes
- **Normal**: Navigation and commands
- **Insert**: Text editing (`i`, `a`, `o`)
- **Visual**: Text selection (`v`, `V`, `Ctrl-v`)
- **Command**: Ex commands (`:`)