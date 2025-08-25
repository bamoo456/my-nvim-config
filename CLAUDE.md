# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Structure

This is a Neovim configuration using Lua with Packer.nvim for plugin management. The configuration follows a modular structure with all Lua modules under `lua/gechen/`.

### Core Architecture

**Entry Point**: `init.lua` loads all configuration modules in a specific order:
1. Plugin setup (Packer initialization and plugin declarations)
2. Core settings (options, keymaps, colorscheme)
3. Individual plugin configurations
4. LSP setup (Mason, LSPSaga, LSPConfig, null-ls)
5. UI enhancements (treesitter, gitsigns, barbar)

**Module Organization**:
- `lua/gechen/plugins-setup.lua` - Packer plugin declarations and auto-installation logic
- `lua/gechen/core/` - Core Neovim settings (options, keymaps, colorscheme)
- `lua/gechen/plugins/` - Individual plugin configurations
- `lua/gechen/plugins/lsp/` - Language Server Protocol configurations

## Development Commands

### Plugin Management
```bash
# Install/update/clean plugins (auto-triggers on save of plugins-setup.lua)
:PackerSync

# Compile plugin configuration
:PackerCompile

# Check plugin status
:PackerStatus
```

### LSP and Formatting
```bash
# Format Lua files with stylua (configured in stylua.toml)
stylua lua/

# Restart LSP server
# Keymap: <leader>rs
:LspRestart

# Mason commands for LSP management
:Mason
:MasonInstall <server>
:MasonUninstall <server>
```

### Key Bindings System

Leader key is set to `<Space>`. The configuration uses extensive keymaps defined in `lua/gechen/core/keymaps.lua`.

### Visual-Multi Plugin Configuration

The vim-visual-multi plugin is configured in `lua/gechen/plugins-setup.lua` (lines 104-117). Current vertical cursor keybindings:
- `<C-S-Down>` - Add cursor down
- `<C-S-Up>` - Add cursor up

These are set via `vim.g.VM_maps` in the `setup` function. If there are issues with these keybindings:
1. Check if the keys conflict with terminal or OS shortcuts
2. Verify the plugin is properly loaded with `:PackerStatus`
3. Consider alternative keybindings that don't use Shift+Control combinations

## Plugin Management with Packer

Packer auto-installs on first run and auto-syncs when `plugins-setup.lua` is saved. The compiled configuration is stored in `plugin/packer_compiled.lua` (gitignored).

## LSP Configuration

The setup uses Mason for LSP server management with automatic installation of:
- TypeScript/JavaScript: tsserver, eslint_d, prettier
- Web: html, cssls, tailwindcss, emmet_ls
- Lua: lua_ls, stylua

## Code Style

Lua formatting is enforced via stylua with settings in `stylua.toml`:
- 120 column width
- 2-space indentation
- Unix line endings
- Auto-prefer double quotes

## Testing and Validation

To validate the configuration:
1. Open Neovim and check for errors: `:checkhealth`
2. Verify plugins loaded: `:PackerStatus`
3. Test LSP functionality: Open a supported file type and check `:LspInfo`
4. Test keybindings: Try leader-based commands (e.g., `<Space>ff` for file search)

## Common Issues and Solutions

### Visual-Multi Keybinding Issues
If vertical cursor movement isn't working:
- The keybindings use `<C-S-Down>` and `<C-S-Up>` which may conflict with terminal emulators
- Alternative keybindings can be set by modifying `vim.g.VM_maps` in `plugins-setup.lua`
- Check `:map <C-S-Down>` to see if the mapping is properly registered

### Packer Compilation Issues
If plugins aren't loading:
1. Delete `plugin/packer_compiled.lua`
2. Run `:PackerSync`
3. Restart Neovim

### LSP Not Working
1. Run `:Mason` to check installed servers
2. Run `:LspInfo` in a file to check active LSP
3. Check Mason logs: `:MasonLog`