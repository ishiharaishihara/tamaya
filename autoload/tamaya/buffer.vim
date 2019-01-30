function! tamaya#buffer#new(bufname) abort
    execute 'edit' fnameescape(a:bufname)
    setlocal modifiable
    silent %delete _
    setlocal buftype=nofile bufhidden=wipe
endfunction
