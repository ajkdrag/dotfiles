-- Plugin manager setup
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = false }, -- don't auto-check for updates on servers
  change_detection = { notify = false },
})
