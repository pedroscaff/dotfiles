" vim: foldmethod=marker
" PLUGINS {{{
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls'
Plug 'neoclide/coc-css'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'cespare/vim-toml'
Plug 'jonsmithers/vim-html-template-literals'
let g:htl_css_templates = 1
Plug 'alvan/vim-closetag'
" CLOSE TAG CONFIG {{{
let g:closetag_filetypes = 'html,xhtml,phtml,javascript,typescript'
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion,litHtmlRegion',
      \ 'javascript.jsx': 'jsxRegion,litHtmlRegion',
      \ 'javascript':     'litHtmlRegion',
      \ 'typescript':     'litHtmlRegion',
      \ }
" }}}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'mhinz/vim-signify'      " git status in the sign column
" signify {{{
" let g:signify_sign_add = '▎'
" let g:signify_sign_delete = '▎'
" let g:signify_sign_delete_first_line = '▀'
let g:signify_sign_change = '~'
" let g:signify_sign_changedelete = g:signify_sign_change
" let g:signify_sign_show_text = 0

hi SignifySignChange guibg=NONE ctermbg=NONE
hi SignifySignAdd guibg=NONE ctermbg=NONE
hi SignifySignDelete guibg=NONE ctermbg=NONE

nmap <silent> ]h <Plug>(signify-next-hunk)
nmap <silent> [h <Plug>(signify-prev-hunk)
" }}}
Plug 'cohama/lexima.vim'      " auto-close parens, brackets, etc.
call plug#end()
" }}}
" KEY BINDINGS {{{
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}}
" SET {{{
set statusline^=%{coc#status()}
set tabstop=2
set shiftwidth=2
set expandtab           " Insert spaces when TAB is pressed.<Paste>
set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set background=dark
set signcolumn=yes
set foldmethod=syntax
set foldlevelstart=3
" }}}
colorscheme PaperColor
" LIGHTLINE {{{
let g:lightline = {
\        'colorscheme': 'PaperColor',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
\}
" }}}
" COMMAND SHORTCURS {{{
cnoreabbrev f Files
cnoreabbrev Q q
" }}}
" FZF HIDE STATUS LINE {{{
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" }}}
