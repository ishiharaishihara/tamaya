function! tamaya#start(...) abort
     call tamaya#content#init()
     call tamaya#content#animate()
endfunction


function! tamaya#timer(time) abort
    let l:disp = {"flag":0}

    function! l:disp.call(...) abort
        call timer_pause(g:calltimer,1)
        call tamaya#content#init()
        call tamaya#content#animate()
    endfunction

    let g:calltimer = timer_start(a:time, l:disp.call,{"repeat":-1})
endfunction
