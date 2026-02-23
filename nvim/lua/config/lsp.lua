if not vim.lsp.enable then return end

local lsp = vim.lsp

lsp.enable({
  'ts_ls'
})

local capabilities = nil
if pcall(require, 'blink.cmp') then
  capabilities = require('blink.cmp').get_lsp_capabilities()
end

lsp.config('*', {
  root_markers = {'.git'},
  capabilities = capabilities
})

vim.api.nvim_create_autocmd({'LspAttach'}, {
  group = vim.api.nvim_create_augroup('lspattach', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- TODO: what does this do?
    vim.opt_local.omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'goto_definition' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'goto declaration' })
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, { desc = 'goto type definition' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'show references' })
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'show code actions' })
    vim.keymap.set('n', 'grr', vim.lsp.buf.rename, { desc = 'rename' })

    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'goto implementation' })
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = false})
    end

    if client:supports_method('textDocument/formatting') then
      vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'format' })
    end

    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd({'BufWritePre'}, {
        group = vim.api.nvim_create_augroup('lspattach', {}),
        buffer = args.buf,
        callback = function()
          if vim.b.nofmt then return end
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
