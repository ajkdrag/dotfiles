return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "[F]ind [F]iles" },
    { "<leader>fg", "<cmd>FzfLua live_grep_glob<CR>", desc = "[F]ind [G]rep" },
    { "<leader>fp", "<cmd>FzfLua grep_project<CR>", desc = "[F]ind [P]roject" },
    { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "[F]ind [B]uffers" },
    { "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "[F]ind [H]elp" },
    { "<leader>fk", "<cmd>FzfLua builtin<CR>", desc = "[F]ind [K]ommands" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<CR>", desc = "[F]ind [R]ecent" },
  },
  config = function()
    require("fzf-lua").setup({
      defaults = { git_icons = false },
      winopts = { height = 0.85, width = 0.80 },
    })
  end,
}
