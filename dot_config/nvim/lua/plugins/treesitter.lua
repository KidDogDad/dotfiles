-- File: ~/.config/nvim/lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "fish",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "regex",
      "vim",
      "vimdoc",
      "yaml",
      "dart",
    },
  },
}
