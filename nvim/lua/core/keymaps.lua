-- Keymap configurations
local map = vim.api.nvim_set_keymap

-- Remap 'jk' to Escape in insert mode and visual mode
map('i', 'jk', '<Esc>', { noremap = true })
map('v', 'jk', '<Esc>', { noremap = true })

-- Remap 'j' and 'k' for navigation
map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })


-- Navigate between splits with Ctrl-h/j/k/l
map('n', '<C-J>', '<C-W><C-J>', { noremap = true })
map('n', '<C-K>', '<C-W><C-K>', { noremap = true })
map('n', '<C-L>', '<C-W><C-L>', { noremap = true })
map('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- Clear search highlight
map('n', '<leader>h', ':nohlsearch<CR>', { noremap = true, silent = true })

-- cpp keymaps
map('n', '<leader>cp',
  '<ESC>:w<CR>:!g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -DDEBUG -O2 -o %< % && ./%< < inp <CR>',
  { noremap = true })
map('i', '<leader>cp',
  '<ESC>:w<CR>:!g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -DDEBUG -O2 -o %< % && ./%< < inp <CR>',
  { noremap = true })


map('n', '<leader>pp', '<ESC>:w<CR>:!python3 % < inp<CR>',
  { noremap = true })
map('i', '<leader>pp', '<ESC>:w<CR>:!python3 % < inp<CR>',
  { noremap = true })


-- map("n", "<leader>ck", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
--
-- map("n", "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true }
-- )
--
-- map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
