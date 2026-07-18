return {
  "echasnovski/mini.files",
  version = "*",
  keys = {
    {
      "<leader>ec",
      function()
        local minifiles = require("mini.files")
        if not minifiles.close() then
          minifiles.open(vim.fn.expand("%:p:h") ~= "" and vim.fn.expand("%:p:h") or vim.fn.getcwd(), true)
        end
      end,
      desc = "[E]xplore [C]urrent dir",
    },
    {
      "<leader>en",
      function()
        local minifiles = require("mini.files")
        if not minifiles.close() then
          minifiles.open(vim.fn.stdpath("config"), true)
        end
      end,
      desc = "[E]xplore [N]vim config",
    },
  },
  config = function()
    require("mini.files").setup({
      options = {
        default_directory = vim.fn.getcwd(),
        auto_close = true,
        remember_directory = true,
      },
    })
  end,
}
