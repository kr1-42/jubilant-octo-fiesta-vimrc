" ===========================================================
" Basic Settings
" ===========================================================
set nocompatible          " Disable old Vi compatibility
set noswapfile            " Disable swapfile
set mouse=a               " Enable mouse
set number                " Show line numbers
set nowrap                " Disable line wrapping
set hidden                " Allow background buffers
set confirm               " Ask confirmation instead of failing
set cmdheight=1           " Reduce command line height
set showcmd               " Show partial commands
set laststatus=2          " Always show statusline

" ===========================================================
" Completion & UI Behavior
" ===========================================================
set wildmenu              " Better command-line completion
set wildmode=list:longest " Bash-like completion behavior

syntax enable             " Enable syntax highlighting
set t_Co=256              " Allow all 256 colors
set termguicolors         " True color support

" ===========================================================
" Colors & Themes
" ===========================================================
colorscheme peachpuff
set bg=light

let g:airline_theme = 'fruit_punch'
let g:airline#extensions#tabline#enabled = 1
let g:promptline_theme = 'airline'

" ===========================================================
" Plugins
" ===========================================================
execute pathogen#infect()

" NERDTree: open on start & auto-close
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ call feedkeys(":quit\<CR>:\<BS>") |
            \ endif

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Load separate plugin config if exists
if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif

" ===========================================================
" Keybindings
" ===========================================================
" Lazy pinky: ; becomes :
nnoremap ; :

" Buffer navigation
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Auto-pair mappings
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

" ===========================================================
" Compile & Run (F5)
" ===========================================================
map  <F5> :call CompileRun()<CR>
imap <F5> <Esc>:call CompileRun()<CR>
vmap <F5> <Esc>:call CompileRun()<CR>

function! CompileRun()
    exec "w"

    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "!time ./%<"

    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"

    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %"

    elseif &filetype == 'sh'
        exec "!time bash %"

    elseif &filetype == 'python'
        exec "!time python3 %"

    elseif &filetype == 'html'
        exec "!google-chrome % &"

    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"

    elseif &filetype == 'matlab'
        exec "!time octave %"
    endif
endfunction

