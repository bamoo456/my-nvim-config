# Neovim Configuration

Personal Neovim configuration with LSP support, focused on Java, TypeScript, and web development.

## Features

- 📦 **Plugin Management**: Lazy.nvim with auto-bootstrap
- 🔧 **LSP Support**: Full Language Server Protocol integration via Mason
  - Java (JDTLS with debug/test support)
  - TypeScript/JavaScript
  - HTML/CSS/Tailwind
  - Lua
  - Auto-formatting with toggleable controls (`:FormatToggle`)
- 🎨 **UI Enhancements**: Treesitter, Lualine, Barbar, nvim-tree
- 🔍 **Fuzzy Finding**: Telescope with fzf integration
- ✨ **Auto-completion**: nvim-cmp with snippets
- 🐛 **Debugging**: DAP integration for Java
- 📝 **Code Actions**: LSPSaga for enhanced LSP UI

## Quick Start

1. **Clone this repository:**
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

2. **Install Neovim** (0.9.0 or higher recommended)

3. **Configure Java paths** (required for Java development):
   - Edit `lua/gechen/java-config.lua`
   - Set your Java installation paths (see below)

4. **Launch Neovim:**
   ```bash
   nvim
   ```
   - Lazy.nvim will auto-bootstrap on first run
   - LSP servers will be installed via Mason

## Java Configuration (JDTLS)

**⚠️ REQUIRED FOR JAVA DEVELOPMENT**

Before using Java LSP features, you must configure your Java installation paths.

### Edit `lua/gechen/java-config.lua`

**Note:** `gechen` is a customizable folder name - you can rename it to match your username or preferred namespace (e.g., `lua/yourname/java-config.lua`). Just ensure you update all references consistently throughout the configuration.

Find your Java installations:
```bash
/usr/libexec/java_home -V
```

Then configure the runtimes (paths should point to the JDK home, NOT the bin folder):

```lua
M.runtimes = {
  {
    name = "JavaSE-1.8",
    path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home",
    default = true,
  },
  {
    name = "JavaSE-21",
    path = "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home",
  },
}

-- Optional: Custom JDTLS Java executable (defaults to system java)
-- M.jdtls_java = "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home/bin/java"
```

## Key Bindings

See [MANUAL.md](MANUAL.md) for the complete reference of all key bindings, features, and usage guides.

## Project Structure

```
.
├── init.lua                    # Main entry point
├── lua/gechen/
│   ├── core/                   # Core Neovim settings
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── colorscheme.lua
│   ├── plugins/                # Plugin configurations
│   │   ├── lsp/               # LSP configurations
│   │   │   ├── mason.lua
│   │   │   ├── lspconfig.lua
│   │   │   ├── lspsaga.lua
│   │   │   ├── null-ls.lua
│   │   │   └── jdtls.lua      # Java LSP
│   │   └── ...
│   ├── java-config.lua         # ⚠️ EDIT THIS for Java paths
│   └── lazy.lua                # Lazy.nvim plugin declarations
└── stylua.toml                 # Lua formatting config
```

## Installed LSP Servers

- **Java**: jdtls (requires configuration - see above)
- **TypeScript/JavaScript**: tsserver, eslint_d, prettier
- **HTML/CSS**: html, cssls, tailwindcss, emmet_ls
- **Lua**: lua_ls, stylua

Install additional servers via `:Mason`

## Troubleshooting

### JDTLS Not Working

1. Verify `java-config.lua` is configured with your Java paths
2. Check Java 17+ is installed: `java -version`
3. Install JDTLS via Mason: `:Mason` → search for "jdtls"
4. Check Neovim messages: `:messages`
5. Verify LSP status in a Java file: `:LspInfo`

### Plugins Not Loading

1. Open Neovim and run: `:Lazy sync`
2. Check plugin status: `:Lazy`
3. Restart Neovim

### LSP Not Attaching

1. Check Mason: `:Mason`
2. Check LSP status: `:LspInfo`
3. Check logs: `:MasonLog`

## Requirements

- Neovim >= 0.9.0
- Git
- Node.js (for TypeScript/JavaScript LSP)
- Java 17+ (for Java development)
- ripgrep (for Telescope live grep)
- fd (optional, for faster file finding)

## License

Personal configuration - feel free to use and modify as needed.
