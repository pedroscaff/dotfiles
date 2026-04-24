local opt = vim.opt

opt.number = true
opt.cursorline = true

-- connect system clipboard
-- opt.clipboard:prepend({ 'unnamedplus' })

-- preview supported ops in split buffer
opt.inccommand = 'split'

-- show whitespace indicators
opt.list = true
opt.listchars:append({
  trail = '¬',
  tab = '> ',
  -- space = '·',
  -- lead = '·',
})
opt.showbreak = '↪ '

-- show indicator and wrap text at 80 chars
opt.colorcolumn = '+1'
opt.textwidth = 80
opt.wrap = true

opt.conceallevel = 2
opt.concealcursor = nil

-- use treesitter to determine folds
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99
