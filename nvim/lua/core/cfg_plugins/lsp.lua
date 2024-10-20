local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local function default_setup(server)
  require('lspconfig')[server].setup({
    capabilities = lsp_capabilities,
  })
end

-- special setup for few languages like dart
require('lspconfig').dartls.setup({
  cmd = { "dart", 'language-server', '--protocol=lsp' },
}
)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'ruff_lsp', 'pylsp' },
  handlers = {
    default_setup,
    -- custom configs here: https://lsp-zero.netlify.app/v3.x/blog/you-might-not-need-lsp-zero.html
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            telemetry = { enable = false },
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })
    end,

    pylsp = function()
      require('lspconfig').pylsp.setup({
        capabilities = lsp_capabilities,
        settings = {
          pylsp = {
            plugins = {
              ruff = {
                enabled = true
              },
              pycodestyle = {
                enabled = false
              }
            },
          }
        }
      })
    end

  },
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
    { name = 'codeium' }
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})


-- lua/core/keymaps.lua
function table.merge(t1, t2)
  local merged = {}
  for k, v in pairs(t1) do merged[k] = v end
  for k, v in pairs(t2) do merged[k] = v end
  return merged
end

vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
      table.merge(opts, { desc = "code [F]ormat" }))
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>',
      table.merge(opts, { desc = "code [A]ctions" }))
  end
})
