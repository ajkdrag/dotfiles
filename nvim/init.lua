-- Disable netrw (we use mini.files or oil)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core modules in order
require("core.options")   -- vim.opt settings, leader key
require("core.keymaps")   -- all keymaps in one place
require("core.lazy")      -- plugin declarations + lazy setup
require("core.autocmds")  -- autocommands
