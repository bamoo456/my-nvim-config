-- JDTLS (Java Development Tools Language Server) configuration
-- Using nvim-jdtls plugin for better Java support

local jdtls = require("jdtls")

-- Determine OS for configuration
local config_dir = "config_mac"
if vim.fn.has("linux") == 1 then
  config_dir = "config_linux"
elseif vim.fn.has("win32") == 1 then
  config_dir = "config_win"
end

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

-- Eclipse jdtls location
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

if launcher_jar == "" then
  vim.notify("JDTLS launcher jar not found. Please install jdtls via Mason.", vim.log.levels.ERROR)
  return
end

-- Auto-detect Lombok JAR (prefer user-provided stable path, fallback to Maven cache)
local function find_lombok_jar()
  local user_lombok = vim.fn.expand("~/.local/share/jdtls/lombok.jar")
  if vim.loop.fs_stat(user_lombok) then
    return user_lombok
  end

  local lombok_pattern = vim.fn.expand("~/.m2/repository/org/projectlombok/lombok/*/lombok-*.jar")
  local lombok_jars = vim.fn.glob(lombok_pattern, false, true)
  if #lombok_jars > 0 then
    table.sort(lombok_jars)
    return lombok_jars[#lombok_jars]
  end
  return nil
end

local lombok_jar = find_lombok_jar()

-- Workspace directory
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. project_name

-- Workspace auto-heal helpers
local function jdtls_stop_wrapper_clients()
  local clients = vim.lsp.get_clients({ name = "jdtls" })
  for _, client in ipairs(clients or {}) do
    local cmd0 = (client.config and client.config.cmd and client.config.cmd[1]) or ""
    if cmd0 == "jdtls" then
      vim.lsp.stop_client(client.id)
    end
  end
end

local function jdtls_clean_corrupt_caches(dir)
  local core_dir = dir .. "/.metadata/.plugins/org.eclipse.jdt.core"
  local candidates = { "nonChainingJarsCache", "externalFilesCache" }
  for _, fname in ipairs(candidates) do
    local p = core_dir .. "/" .. fname
    local st = vim.loop.fs_stat(p)
    if st and st.type == "file" and st.size == 0 then
      pcall(vim.loop.fs_unlink, p)
    end
  end
end

-- Get the current buffer
local bufnr = vim.api.nvim_get_current_buf()

-- LSP keymaps (same as your existing setup)
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  
  -- Set keybinds
  vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
  vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
  vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
  
  -- Java specific keymaps
  vim.keymap.set("n", "<leader>jo", "<cmd>lua require('jdtls').organize_imports()<CR>", opts)
  vim.keymap.set("n", "<leader>jv", "<cmd>lua require('jdtls').extract_variable()<CR>", opts)
  vim.keymap.set("v", "<leader>jv", "<cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
  vim.keymap.set("n", "<leader>jc", "<cmd>lua require('jdtls').extract_constant()<CR>", opts)
  vim.keymap.set("v", "<leader>jc", "<cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
  vim.keymap.set("v", "<leader>jm", "<cmd>lua require('jdtls').extract_method(true)<CR>", opts)
  vim.keymap.set("n", "<leader>jt", "<cmd>lua require('jdtls').test_class()<CR>", opts)
  vim.keymap.set("n", "<leader>jn", "<cmd>lua require('jdtls').test_nearest_method()<CR>", opts)
end

-- Capabilities for autocompletion
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
if cmp_nvim_lsp_status then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Build JDTLS command with conditional Lombok support
local cmd = {
  "/Library/Java/JavaVirtualMachines/zulu-21.jdk/zulu-21.jdk/Contents/Home/bin/java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xmx4g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",
}

-- Add Lombok support if available
if lombok_jar then
  table.insert(cmd, "-javaagent:" .. lombok_jar)
  vim.notify("JDTLS: Using Lombok from " .. lombok_jar, vim.log.levels.INFO)
end

-- Add remaining arguments
table.insert(cmd, "-jar")
table.insert(cmd, launcher_jar)
table.insert(cmd, "-configuration")
table.insert(cmd, jdtls_path .. "/" .. config_dir)
table.insert(cmd, "-data")
table.insert(cmd, workspace_dir)

-- JDTLS configuration
local config = {
  -- Command to start the language server
  cmd = cmd,

  -- Root directory of the project
  root_dir = root_dir,

  -- Language server settings
  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        -- Configure Java runtimes
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/",
            default = true,
          },
          {
            name = "JavaSE-21",
            path = "/Library/Java/JavaVirtualMachines/zulu-21.jdk/zulu-21.jdk/Contents/Home/",
          },
        },
      },
      maven = {
        downloadSources = true,
        updateSnapshots = false,
      },
      -- Enable annotation processing
      compile = {
        nullAnalysis = {
          mode = "automatic"
        },
      },
      maxConcurrentBuilds = 1,
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org"
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        useBlocks = true,
      },
      -- Lombok support - auto-detect from project dependencies
      autobuild = {
        enabled = true,
      },
      project = {
        referencedLibraries = {
          "lib/**/*.jar",
          "**/lombok*.jar",
        },
      },
      -- Enhanced Lombok support
      settings = {
        lombok = {
          enabled = true,
        },
      },
      cleanup = {
        actionsOnSave = {
          "addOverride",
          "addDeprecated",
          "stringConcatToTextBlock",
          "invertEquals",
          "addFinalModifier",
          "instanceofPatternMatch",
          "lambdaExpression",
          "switchExpression",
        },
      },
    },
  },

  -- Language server initialization options
  init_options = {
    bundles = {},
    extendedClientCapabilities = {
      progressReportProvider = false,
      classFileContentsSupport = true,
      generateToStringPromptSupport = true,
      hashCodeEqualsPromptSupport = true,
      advancedExtractRefactoringSupport = true,
      advancedOrganizeImportsSupport = true,
      generateConstructorsPromptSupport = true,
      generateDelegateMethodsPromptSupport = true,
      moveRefactoringSupport = true,
    },
  },

  -- LSP capabilities and handlers
  capabilities = capabilities,
  on_attach = on_attach,

  -- Flags
  flags = {
    allow_incremental_sync = true,
  },
}

-- Only start JDTLS if we're in a Java file
if vim.bo.filetype == "java" then
  jdtls.start_or_attach(config)
end

-- Auto-command to start JDTLS for Java files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    -- Stop any existing LSP clients for this buffer first (avoid deprecated API)
    jdtls_stop_wrapper_clients()
    
    -- Wait a moment for cleanup
    vim.defer_fn(function()
      -- Recreate config with current buffer's root directory
      local current_root = require("jdtls.setup").find_root(root_markers)
      if current_root and current_root ~= "" then
        local project_name = vim.fn.fnamemodify(current_root, ":p:h:t")
        local workspace_dir = vim.fn.expand("~/.cache/jdtls-workspace/") .. project_name
        
        -- Update workspace directory for current project
        local updated_config = vim.deepcopy(config)
        updated_config.cmd[#updated_config.cmd] = workspace_dir
        updated_config.root_dir = current_root
        -- Auto-heal corrupted JDT caches (EOFException on nonChainingJarsCache)
        jdtls_clean_corrupt_caches(workspace_dir)
        
        jdtls.start_or_attach(updated_config)
      end
    end, 100)
  end,
})
