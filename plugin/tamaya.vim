if exists('g:loaded_tamaya')
    finish
endif
let g:loaded_tamaya = 1
let g:tamaya_list = []

command! Tamaya call tamaya#start(<f-args>)
command! -nargs=1 TamayaTimer call tamaya#timer(<f-args>)

if exists('g:tamaya_time')
    augroup tamaya
        autocmd! VimEnter * call tamaya#timer(g:tamaya_time)
    augroup END
endif
