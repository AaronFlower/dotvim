" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" pathogen activation by easonzhan

echo ">_._<"

" Pathogen load
filetype off

" To disable a plugin, add it's bundle name to the following list
" let g:pathogen_disabled = ['dracula-vim']

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

" color scheme disable dracula and use gruvbox
" color dracula
" colorscheme gruvbox

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set nu

" Autowrite that writes the content of the file automatically if you call :make
set autowrite

"For tab characters that appear 2-spaces-wide:
set tabstop=2
set softtabstop=0 noexpandtab
set shiftwidth=2

"For edit file forget with sudo

" tell vim to keep a backup file
set backup

" tell vim where to put its backpu file
set backupdir=/private/tmp

" tell vim where to put swap files
set dir=/private/tmp


" nerdtree
" autocmd vimenter * NERDTree

" toggle NERDTree
" map <C-n> :NERDTreeToggle<CR>

" close vim app if only NERDTree exits
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" remap emmet-vim default <C-Y> leader
let g:user_emmet_leader_key='<C-E>'


" vim guidelines
set colorcolumn=100
highlight ColorColumn ctermbg=darkgray

" EditorConfig
let g:EditorConfig_core_mode = 'external_command'

" Use Vim-plug as plugins manager ---{{{
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins

" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

" AirLine
Plug 'vim-airline/vim-airline'

" Tomorrow Theme
Plug 'chriskempson/base16-vim'
Plug 'fatih/molokai'

" Vue Syntax
Plug 'posva/vim-vue'

" Vim Snippets
Plug 'honza/vim-snippets'

" Vim go plugin
Plug 'fatih/vim-go'
Plug 'AndrewRadev/splitjoin.vim'
"Plug 'SirVer/ultisnips'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
" }}}

" Save marks when exit
set viminfo='100,f1

" fzf config
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" <### Editor KeyMap Begin###> ----{{{
" Set mapleader, maplocalleader
let mapleader=","
let maplocalleader=","

" insert mode user jk to ESC
inoremap jk <esc>
inoremap <esc> <nop>

" save your file
nnoremap <leader>s :w<cr>
" close your file
nnoremap <leader>q :q<cr>

" edit your vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" source your vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" switch current line with next line
nnoremap - ddp

" switch current line with previous line
nnoremap _ ddkP

" Convert word to uppercase in Insert Mode	
inoremap <leader><c-u> <esc>gUiwea

" Convert word to uppercase in Normal Mode
nnoremap <leader><c-u> gUiw

" Wrap word with "
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel


" Wrap word with ' 
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" Wrap word with () 
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel

" Open file with zfz
nnoremap <c-p> :Files<cr>
inoremap <c-p> :Files<cr>

" quickfix
noremap <c-n> :cnext<cr>
noremap <c-m> :cprevious<cr>
nnoremap <leader>a :cclose<cr>

" Go
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
	
" Grep WORD
" nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr><c-l>:copen<cr>

" Habit breaking arrow keys and esc key ---- {{{
noremap <Up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

inoremap <Up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" }}}

" <### Ediror KeyMap End ###>
" }}}


" Abbreviations
" eles else
:iabbrev eles else 


" Folding Vimscript files
" Vimscript file setting --------{{{
augroup FileType_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" VimGO -zo----{{{
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_metalinter_enabled = ['golint', 'errcheck']
let g:go_metalinter_autosave = 1

let g:go_auto_type_info = 1
set updatetime=100
" }}}

" Colorscheme after plugin loaded --- {{{

" monokai
let g:rehash256 = 1
let g:molokai_original = 1
color molokai

"}}}
