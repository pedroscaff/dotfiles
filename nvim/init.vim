" vim: foldmethod=marker
" PLUGINS {{{
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'cohama/lexima.vim'      " auto-close parens, brackets, etc.
" COC CONFIG {{{
" " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! JumpToDefinition()
  call CocActionAsync('jumpDefinition', 'tabe')
endfunction

" Use K to show documentation in preview window.
nnoremap <C-K> :call JumpToDefinition()<CR>

" }}}
Plug 'cespare/vim-toml'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'zackhsi/fzf-tags'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'mhinz/vim-signify'      " git status in the sign column
Plug 'leafgarland/typescript-vim'
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
Plug 'preservim/nerdtree'
Plug 'chrisbra/csv.vim'
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
call plug#end()
" }}}
" LEXIMA CONFIG {{{
" lexima rules that use <CR> (newline/endwise) conflicts with coc
let g:lexima_no_default_rules = 1
let g:lexima_enable_newline_rules = 0
let g:lexima_enable_endwise_rules = 0
call lexima#set_default_rules()
" }}}
" SET {{{
" set statusline^=%{coc#status()}
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
" THEME {{{
set termguicolors
autocmd vimenter * ++nested colorscheme gruvbox
" }}}
" LIGHTLINE {{{
let g:lightline = {
\        'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightLineFileName'
      \ },
\}
function! LightLineFileName()
  return expand('%')
endfunction
" }}}
" COMMAND SHORTCURS {{{
cnoreabbrev f Files
cnoreabbrev Q q
cnoreabbrev n e %:h/
" }}}
" FZF HIDE STATUS LINE {{{
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
" }}}
" SET SYNTAX HIGHLIGHTING {{{
autocmd BufNewFile,BufRead *.launch set syntax=xml
autocmd BufNewFile,BufRead *.tf set syntax=tf
" }}}
" fzf ctags {{{               
nnoremap <C-p> :GFiles<CR>              
inoremap <C-s> <C-o>:FZFTags<CR> 
nnoremap <C-s> :FZFTags<CR>
nnoremap <C-u> :History<CR>  
autocmd VimEnter * silent execute "!/usr/local/bin/tags-git-hook.sh" | redraw!
set tags=.git/tags
" }}}

function! GetGitRemoteUrl()
	silent !clear
	" execute "!" . "/home/pedroscaff/dev/git-get-remote-url/target/release/git-get-remote-url" . " " . expand("%:p") line(".") . " | wl-copy"
	execute "!" . "/home/pedroscaff/dev/git-get-remote-url/target/release/git-get-remote-url" . " " . expand("%:p") line(".") . " --clipboard"
endfunction
nnoremap YY :call GetGitRemoteUrl() <cr>
" NERDTREE CONFIG {{{
nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
" }}}
" COPILOT CONFIG {{{
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
" }}}
