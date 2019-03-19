" Startup {{{1

augroup MyAutoCmd
  autocmd!
augroup END

let $MY_VIM_PLUGINS = $HOME . '/.vim-plugins'

function! s:set_runtimepath()
  set runtimepath&
  let paths = split(&runtimepath, ',')
  call insert(paths, $MY_VIM_PLUGINS . '/*', index(paths, $HOME . '/.vim') + 1)
  call insert(paths, $MY_VIM_PLUGINS . '/*/after', index(paths, $HOME . '/.vim/after'))
  let &runtimepath = join(paths, ',')
endfunction

call s:set_runtimepath()

filetype plugin indent on

syntax enable

" Options {{{1

set backspace=indent,eol,start
set fileformats=unix,dos,mac
set history=200
set laststatus=2
set list
set listchars=tab:>-,trail:_,extends:>,precedes:<
set nobackup
set noswapfile
set pastetoggle=<C-@>
set ruler
set scrolloff=5
set showcmd
set tags=./tags;,tags;

set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2

set ignorecase
set incsearch
set smartcase

set timeout
set timeoutlen=1000
set ttimeout
set ttimeoutlen=100

set wildmenu
set wildignore&
set wildignore+=*.class
set wildignore+=*.o

set fileencodings=ucs-bom,iso-2022-jp-3,euc-jisx0213,euc-jp,cp932,utf-8,latin1

autocmd MyAutoCmd BufReadPost * call s:reset_fileencoding()

function! s:reset_fileencoding()
  if &modifiable && !search('[^\x00-\x7F]', 'cnw')
    setlocal fileencoding=
  endif
endfunction

" Mappings {{{1

let g:mapleader = ';'
let g:maplocalleader = ','

nnoremap <C-n> gt
nnoremap <C-p> gT

nnoremap <silent> <C-l> :nohlsearch<Return><C-l>

nnoremap <Leader>e :e %:h/
nnoremap <Leader>n :new %:h/

nnoremap <Leader>d <Nop>
nnoremap <Leader>dd :windo diffthis<Return>
nnoremap <Leader>do :windo diffoff<Return>

inoremap <silent> <Leader>d <C-r>=strftime('%Y/%m/%d')<Return>
inoremap <silent> <Leader>t <C-r>=strftime('%Y/%m/%d %H:%m:%d')<Return>

if !has('gui_running')
  execute "set <M-n>=\en"
  execute "set <M-p>=\ep"
endif

cnoremap <M-n> <Down>
cnoremap <M-p> <Up>

" Filetypes {{{1

" any {{{2

autocmd MyAutoCmd InsertLeave * set nopaste

" asm {{{2

autocmd MyAutoCmd FileType asm setlocal shiftwidth=8 softtabstop=0 noexpandtab

" c, cpp {{{2

autocmd MyAutoCmd FileType c,cpp setlocal shiftwidth=4 softtabstop=4

" dot-files {{{2

autocmd MyAutoCmd BufNewFile,BufRead dot.* call s:on_dot_prefix()

function! s:on_dot_prefix()
  execute 'doautocmd BufNewFile,BufRead' substitute(expand('<afile>:t'), '^dot\ze\.', '', '')
endfunction

" eruby {{{2

autocmd MyAutoCmd FileType eruby call s:on_FileType_eruby()

function! s:on_FileType_eruby()
  inoremap <buffer> <LocalLeader>e <lt>%<Space><Space>%><Left><Left><Left>
  inoremap <buffer> <LocalLeader>q <lt>%-<Space><Space>-%><Left><Left><Left><Left>
  inoremap <buffer> <LocalLeader>x <lt>%=<Space>%><Left><Left><Left>

  if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= '|'
  else
    let b:undo_ftplugin = ''
  endif

  let b:undo_ftplugin .= 'silent! iunmap <buffer> <LocalLeader>e'
  let b:undo_ftplugin .= '|silent! iunmap <buffer> <LocalLeader>q'
  let b:undo_ftplugin .= '|silent! iunmap <buffer> <LocalLeader>x'
endfunction

" go {{{2

autocmd MyAutoCmd FileType go setlocal shiftwidth=8 softtabstop=2 noexpandtab

" python {{{2

autocmd MyAutoCmd FileType python call s:on_FileType_python()

function! s:on_FileType_python()
  " List classes and methods
  command! -buffer Toc g/\C^\s*\<\%(class\|def\)\>/nu

  if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= '|'
  else
    let b:undo_ftplugin = ''
  endif

  let b:undo_ftplugin .= 'delcommand Toc'

  if executable('python')
    let output = system('python -c ''import sys, os; sys.stdout.write(",".join([x for x in sys.path if os.path.isdir(x)]))''')

    let &l:path = '.,' . output . ',,'

    let b:undo_ftplugin .= '|setlocal path<'
  endif
endfunction

" ruby {{{2

autocmd MyAutoCmd FileType ruby call s:on_FileType_ruby()

function! s:on_FileType_ruby()
  inoreabbrev <buffer> def def<Return>end<Up><End>
  inoreabbrev <buffer> defi def<Space>initialize<Return>end<Up><End>

  nnoremap <buffer> <LocalLeader><LocalLeader> :execute 'windo up' <Bar> !clear; bin/rspec %

  " List modules, classes, methods, attributes, aliases, access controls and constants
  command! -buffer Toc g/\C^\s*\%(\<\%(module\|class\|def\|attr\%(_\w\+\)\=\|alias\%(_method\)\=\|public\|protected\|private\)\>\|\u\w*\s*=[=]\@!\)/nu

  if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= '|'
  else
    let b:undo_ftplugin = ''
  endif

  let b:undo_ftplugin .= 'silent! iunabbrev <buffer> def'
  let b:undo_ftplugin .= '|silent! iunabbrev <buffer> defi'
  let b:undo_ftplugin .= '|silent! nunmap <buffer> <LocalLeader><LocalLeader>'
  let b:undo_ftplugin .= '|delcommand Toc'
endfunction

" sh {{{2

let g:is_bash = 1

" vim {{{2

let g:vim_indent_cont = 0

autocmd MyAutoCmd FileType vim call s:on_FileType_vim()

function! s:on_FileType_vim()
  let &l:path = '.,' . &runtimepath . ',,'

  setlocal textwidth=0

  if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= '|'
  else
    let b:undo_ftplugin = ''
  endif

  let b:undo_ftplugin .= 'setlocal path< textwidth<'
endfunction

" __END__ {{{1
" vim: foldmethod=marker
