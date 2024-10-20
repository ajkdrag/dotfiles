local function whichkeySetup()
  local whichkey = require('which-key')

  whichkey.setup()
  whichkey.register({
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    ['<leader>e'] = { name = '[E]xplorer', _ = 'which_key_ignore' },
  })
end

whichkeySetup()
