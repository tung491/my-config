set nocompatible
set encoding=utf-8
ser history=50

set autoindent
set cindent
set smartindent

set expandtab
set sw=4
set ts=4

set directory=$HOME/.vim/swapfiles/

set backspace=indent,eol,start
set cursorline
set colorcolumn=80
set nu
set ruler
set showcmd
syntax on

set hlsearch
set incsearch
set showmatch
set ignorecase
set smartcase

colorscheme koehler
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    colorscheme solarized
endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree |   wincmd l | endif
let g:NERDTreeChDirMode=2

nnoremap j gj
nnoremap k gk

nmap gc :cd %:h<CR>

nmap <Leader>ag :grep
nmap <Leader>p :se paste!<CR>i
nmap <Leader>src :source %MYVIMRC<CR>
nmap <C-K> :q<CR>
nmap <C-X> :e#<CR>
nmap <C-T> :tabe<CR>
nmap <C-E> :NERDTreeToggle<CR>
nmap <tab> :tabnext<CR>
nmap <S-tab> :tabprevious<CR>
nmap <C-N> :next<CR>
nmap <C-B> :prev<CR>

nmap <Leader>gs :Gstatus<CR>
" j = down in vim
nmap <Leader>gj :Git pull<CR>
nmap <Leader>gd :Git diff<CR>
nmap <Leader>ga :Git add %<CR>
nmap <Leader>gc :Gcommit<CR>
nmap <Leader>gp :Git push origin HEAD<CR>
nmap <Leader>gn :Git checkout -b
nmap <Leader>gm :Git checkout master<CR>
nmap <Leader>gb :Git checkout
nmap <Leader>gf :Git fetch --all --prune -v<CR>
nmap <Leader>gr :Git rebase -i origin/

filetype plugin indent on
autocmd FileType text setlocal textwidth=78
autocmd BufNewFile,BufRead *.jinja,*.jinja2 set ft=sls
autocmd BufWritePre * :%s/\s\+$//e

" Python
autocmd FileType python nmap <Leader>r :!python %<CR>
autocmd FileType python nmap <Leader># ggO#!/usr/bin/env python<CR># -*- coding: utf-8 -*-<Esc>o
autocmd FileType python nmap <Leader>m Giif __name__ == "__main__":<CR>
autocmd FileType python set omnifunc=pythoncomplete#Complete

function! CurDir()
    return substitute(getcwd(), expand("$HOME"), "~", "g")
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function! HasFlake()
  if !exists("*Flake8()") && executable('flake8')
      return ''
  endif
  return 'NO'
endfunction

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L\ %{fugitive#statusline()}\ FLAKE:%{HasFlake()}
if !exists("*Flake8()") && executable('flake8')
  autocmd BufWritePost *.py call Flake8()
endif

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

