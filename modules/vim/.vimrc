" i have no idea what i'm doing...
" just trying to get this to be as much like a non-modal editor as possible :)

""" keys: """
"normal" mode, ha
" dear squash please just let me get to insert mode
autocmd VimEnter * startinsert
:noremap j i
:noremap <cr> i
:noremap <space> i

"" how to quit vim: ctrl+d
:noremap <c-c> :q<cr>
:noremap <c-d> :q!<cr>
:inoremap <c-c> <esc>:q<cr>
:inoremap <c-d> <esc>:q!<cr>

"" save with [cmd]+[s]
:noremap <esc>[115;9u :w<cr>
:inoremap <esc>[115;9u <esc>:w<cr>i

"""""""""
""" first we get to normal key motion:
""" (in conjunction with esc sequences mapped in kitty.conf)

""" world left + right
" opt-left   \x1b\x62 [esc]+[b]
:noremap <esc>b b
:inoremap <esc>b <esc>bi
" opt-right   \x1b\x62 [esc]+[f]
:noremap <esc>f w
:inoremap <esc>f <esc>wwi

""" start/end of line
" [cmd]+[left] \x01 ^A
:noremap <c-a> 0
:inoremap <c-a> <esc>0i
" [cmd]+[right] \x05 ^E
:noremap <c-e> $
:inoremap <c-e> <esc>$i

""""""""
""" second we get re-order line up/down
""" as in vscode:
:noremap <esc>[1;3A :m .-2<CR>==
:inoremap <esc>[1;3A <esc>:m .-2<CR>==i
:noremap <esc>[1;3B :m .+1<CR>==
:inoremap <esc>[1;3B <esc>:m .+1<CR>==i

"" un/indent [shift]+[tab]
:noremap <tab> >>
" tab already indents in i mode
:noremap <esc>[Z <<
:inoremap <esc>[Z <esc><<i



syntax on
colorscheme onedark
set termguicolors
" fix bg color on scroll
" https://github.com/kovidgoyal/kitty/issues/108
let &t_ut=''

""" boring stuff: """

set nocompatible
filetype on
filetype plugin on
filetype indent on
set number
set cursorline

set expandtab
set tabstop     =2
set softtabstop =2
set shiftwidth  =2

set ignorecase
set smartcase
set showmatch
set hlsearch

set showcmd
set showmode

set mouse=a
