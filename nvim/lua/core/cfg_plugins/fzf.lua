require "fzf-lua".setup { defaults = { git_icons = false } }

vim.api.nvim_set_keymap("n", "<leader>fb", [[<Cmd>lua require"fzf-lua".buffers()<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>fk", [[<Cmd>lua require"fzf-lua".builtin()<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>ff", [[<Cmd>lua require"fzf-lua".files()<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>fg", [[<Cmd>lua require"fzf-lua".live_grep_glob()<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>fp", [[<Cmd>lua require"fzf-lua".grep_project()<CR>]], {})
vim.api.nvim_set_keymap("n", "<leader>fh", [[<Cmd>lua require"fzf-lua".help_tags()<CR>]], {})

require("fzf-lua").utils.info(
  "|<leader>fb buffers|<leader>ff files|<leader>fp grep|<leader>fg live grep|<leader>fk builtin|<leader>fh help|")
