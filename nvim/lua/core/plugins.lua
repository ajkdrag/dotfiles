require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  { 'echasnovski/mini.files', version = '*' },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  "numToStr/Comment.nvim",
  "nvim-treesitter/nvim-treesitter",
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "brenoprata10/nvim-highlight-colors",
  { 'augmentcode/augment.vim' },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   config = true,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  -- },
  --   {
  --     "Exafunction/codeium.nvim",
  --     dependencies = {
  --       "nvim-lua/plenary.nvim",
  --       "hrsh7th/nvim-cmp"
  --     }
  --   }
})
