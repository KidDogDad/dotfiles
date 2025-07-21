return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- optional for vim.ui.select
  },
  config = function()
    require("flutter-tools").setup({
      -- LSP configuration is the most important part
      lsp = {
        -- This is the main settings object for the dart_language_server
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisExcludedFolders = { "**/build/**" },
          renameFilesWithClasses = "prompt", -- "always" or "never"
          enableSnippets = true,
        },
      },
      -- Other plugin settings
      -- decorations = {
      --   statusline = {
      --     --  What symbols to use for the statusline component
      --     device = "📱",
      --   },
      -- },
    })
  end,
}
