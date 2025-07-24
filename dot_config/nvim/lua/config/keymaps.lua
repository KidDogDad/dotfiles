-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "B", "^", { desc = "Start of line" })
vim.keymap.set({ "n", "v" }, "E", "$", { desc = "End of line" })
