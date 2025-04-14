local cmp = require('cmp')

cmp.setup({
  sources = cmp.config.sources({
    -- { name = "codeium" },
    { name = "codecompanion" },
    { name = 'nvim_lsp' },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),

  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

