-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

vim.keymap.set(
  "n",
  "<leader>sp",
  '<cmd>lua require("grug-far").grug_far({ prefills = { paths = vim.fn.expand("%") } })<CR>',
  {
    desc = "Search on current file",
  }
)

vim.keymap.set(
  "n",
  "<leader>r",
  '<cmd>lua vim.ui.input({ prompt = "New name: ", default = vim.fn.expand("%") }, function(newName) if newName and newName ~= "" then vim.cmd("file " .. vim.fn.shellescape(newName)) end end)<CR>',
  {
    desc = "Rename file",
  }
)
