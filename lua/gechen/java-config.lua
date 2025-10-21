-- ========================================
-- Java Configuration for JDTLS
-- ========================================
--
-- ⚠️  IMPORTANT: CONFIGURE YOUR JAVA PATHS BELOW
--
-- This file contains placeholder values. You must edit it with your actual
-- Java installation paths before JDTLS will work.
--
-- See README.md for detailed setup instructions.
--
-- ========================================

local M = {}

-- ========================================
-- JDTLS Server Java Executable
-- ========================================
-- The Java executable used to run JDTLS itself (requires Java 17 or higher)
M.jdtls_java = "/Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home/bin/java"

-- ========================================
-- Java Runtimes for Your Projects
-- ========================================
-- Configure the Java runtimes available for your projects
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

return M
