vim.keymap.set('n', ';<space>', '<cmd>FzfLua global<cr>', { desc = 'fzf: find_global' })
vim.keymap.set('n', ';g', '<cmd>FzfLua grep_visual<cr>', { desc = 'fzf: grep' })
vim.keymap.set('n', ';b', '<cmd>FzfLua buffers<cr>', { desc = 'fzf: buffers' })
vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references<cr>', { desc = 'fzf: buffers' })
