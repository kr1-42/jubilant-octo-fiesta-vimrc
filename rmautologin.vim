" -------------------------------------
" README_AUTO_UPDATE.VIM
" Appends login + timestamp to first line of README.md
" -------------------------------------
augroup ReadmeLogin
    autocmd!
    autocmd BufReadPost README.md call s:append_login_timestamp()
augroup END

function! s:append_login_timestamp()
    let l:user = $USER
    let l:timestamp = strftime("%Y-%m-%d %H:%M:%S")
    let l:first = getline(1)
    let l:new = l:first . " — login: " . l:user . " — " . l:timestamp . "\n"
    call setline(1, l:new)
endfunction

