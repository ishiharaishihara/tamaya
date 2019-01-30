function! tamaya#start(...) abort
    call tamaya#buffer#new('hello')
    if a:0 >= 1
        call tamaya#content#animate(a:1)
    else
        call tamaya#content#animate()
    endif
    sleep 300m
    execute 'quit'
endfunction

function! tamaya#leave() abort
    let l:word = join(g:tamaya_list,'')
    call tamaya#start(l:word)
    let g:tamaya_list = []
endfunction

function! tamaya#auto() abort
    augroup tamaya
       autocmd! InsertCharPre * call add(g:tamaya_list,v:char)
       autocmd! InsertLeave * call tamaya#leave()
   augroup END
endfunction

function! tamaya#timer(time) abort
    let l:disp = {}
    function! l:disp.call(...) abort
        call tamaya#buffer#new('hello')
        call tamaya#content#animate()
    endfunction

    let timer = timer_start(a:time, l:disp.call,{"repeat":-1})
endfunction

