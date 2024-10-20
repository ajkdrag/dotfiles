-- Keymap configurations
local map = vim.api.nvim_set_keymap

-- Remap 'jk' to Escape in insert mode and visual mode
map('i', 'jk', '<Esc>', { noremap = true })
map('v', 'jk', '<Esc>', { noremap = true })

-- Remap 'j' and 'k' for navigation
map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })

-- Map 'H' to move to the beginning of the line and 'L' to move to the end of the line
map('n', 'H', '^', { noremap = true })
map('n', 'L', '$', { noremap = true })

-- Navigate between splits with Ctrl-h/j/k/l
map('n', '<C-J>', '<C-W><C-J>', { noremap = true })
map('n', '<C-K>', '<C-W><C-K>', { noremap = true })
map('n', '<C-L>', '<C-W><C-L>', { noremap = true })
map('n', '<C-H>', '<C-W><C-H>', { noremap = true })

-- Clear search highlight
map('n', '<leader>h', ':nohlsearch<CR>', { noremap = true, silent = true })
