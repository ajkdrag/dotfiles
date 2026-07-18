return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- ponytail: main branch rewrite dropped .configs module
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "python", "vim", "vimdoc", "markdown" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
