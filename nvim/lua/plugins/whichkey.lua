return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup()
    wk.add({
      { "<leader>b", group = "[B]uffer" },
      { "<leader>c", group = "[C]ode" },
      { "<leader>e", group = "[E]xplorer" },
      { "<leader>f", group = "[F]ind" },
      { "<leader>p", group = "[P]ython" },
      { "<leader>s", group = "[S]plit" },
    })
  end,
}
