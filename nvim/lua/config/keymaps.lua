-- v to run on visual mode
vim.keymap.set('v', ';y', '"+y', { desc = 'copy to system clipboard'})
vim.keymap.set('n', ';y', '"+yy', { desc = 'copy to system clipboard'})

