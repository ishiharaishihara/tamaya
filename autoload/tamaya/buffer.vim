function! tamaya#buffer#new(bufname) abort
    execute 'new' fnameescape(a:bufname)
    setlocal modifiable
    silent %delete _
    setlocal buftype=nofile bufhidden=wipe
endfunction
