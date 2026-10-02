vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰷚',
      [vim.diagnostic.severity.WARN] = '󰀦',
      [vim.diagnostic.severity.INFO] = '󰙎',
      [vim.diagnostic.severity.HINT] = '󰛓',
    },
    linehl = {
      -- [vim.diagnostic.severity.ERROR] = 'Search',
      -- [vim.diagnostic.severity.WARN] = '',
      -- [vim.diagnostic.severity.INFO] = '',
      -- [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
  severity_sort = true,
  underline = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  float = {
    source = true,
  },
  virtual_text = false,
  virtual_lines = false,
})

local commonhl = { undercurl = true, force = true }
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', commonhl)
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', commonhl)
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', commonhl)
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', commonhl)

vim.keymap.set('n', 'DD', vim.diagnostic.open_float, { desc = 'diagnostic: current line' })
vim.keymap.set('n', '<leader>d', '<nop>', { desc = "diagnostics" })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'diagnostic: current line' })
vim.keymap.set('n', '<leader>dv', function()
  -- NOTE: this can be used to switch between multiple sets of diagnostics display
  --       currently it only toggles virtual_text
  local visible = vim.diagnostic.config().virtual_text

  if visible then
    -- vim.diagnostic.hide(nil, 0)
    vim.diagnostic.config({ virtual_text = false })
  else
    -- vim.diagnostic.show(nil, 0)
    vim.diagnostic.config({ virtual_text = true })
  end
end, { desc = 'diagnostic: toggle visibility' })

vim.keymap.set('n', '<leader>da', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'diagnostic: toggle all' })
