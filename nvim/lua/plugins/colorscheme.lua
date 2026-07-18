return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
      styles = { comments = { "italic" } },
    })
    vim.cmd("colorscheme catppuccin")
  end,
}
