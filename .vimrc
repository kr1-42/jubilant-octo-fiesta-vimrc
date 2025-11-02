" show line number
set number
" status bar
set laststatus=2
" Better command-line completion
set wildmenu
" Show partial commands in the last line of the screen
set showcmd
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=1
" vim only
set nocompatible
" theme
let g:airline_theme='fruit_punch'
" smarter tab line 
let g:airline#extensions#tabline#enabled = 1
let g:promptline_theme = 'airline'
syntax enable
" all colors for Vim
set t_Co=256
" background color
colorscheme peachpuff
set bg=light
set termguicolors
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
" lazy pinky
nnoremap ; :
" buftab
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
execute pathogen#infect()
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif
