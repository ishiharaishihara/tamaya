if exists('g:loaded_tamaya')
    finish
endif
let g:loaded_tamaya = 1
let g:tamaya_list = []

command! -nargs=? Tamaya call tamaya#start(<f-args>)

command! TamayaAuto call tamaya#auto()

command! TamayaClear au! tamaya

command! -nargs=1 TamayaTimer call tamaya#timer(<f-args>)


"let g:auto_tamaya = 1

if exists('g:auto_tamaya')
    call tamaya#auto()
endif

if exists('g:tamaya_time')
    augroup tamaya
        autocmd! VimEnter * call tamaya#timer(g:tamaya_time)
    augroup END
endif
