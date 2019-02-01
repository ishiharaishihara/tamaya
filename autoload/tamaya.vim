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
    let l:disp = {"flag":0}

    function! l:disp.tamaya(...) abort
        let l:x = Random(winwidth(0) - 19)
        let l:y = Random(winheight(0) - 14)
        call timer_pause(g:calltimer,1)
        call tamaya#buffer#new('tamaya')
        call tamaya#content#animate(l:x,l:y)
    endfunction

    function! l:disp.call(...) abort
        let g:tamayatimer = timer_start(4000, l:self.tamaya,{"repeat":-1})
        call timer_pause(g:tamayatimer,0)
    endfunction

    let g:calltimer = timer_start(a:time, l:disp.call,{"repeat":-1})
endfunction

function! Random(n) abort
    let l:match_end = matchend(reltimestr(reltime()), '\d\+\.') + 1
    let l:rand = reltimestr(reltime())[l:match_end : ] % (a:n + 1)
    return l:rand
endfunction
