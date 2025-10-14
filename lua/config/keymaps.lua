-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

vim.keymap.set("n", "<leader>sp", function()
  require("grug-far").open({ prefills = { paths = vim.fn.expand("%"), search = vim.fn.expand("<cword>") } })
end, { desc = "Search on current file" })

vim.keymap.set({ "n", "x" }, "<leader>si", function()
  require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
end, { desc = "grug-far: Search within range" })

vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
