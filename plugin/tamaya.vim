if exists('g:loaded_tamaya')
    finish
endif
let g:loaded_tamaya = 1
let g:tamaya_list = []

command! -nargs=? Tamaya call tamaya#start(<f-args>)

command! TamayaAuto call tamaya#auto()

command! TamayaClear au! tamaya

"let g:auto_tamaya = 1

if exists('g:auto_tamaya')
    call tamaya#auto()
endif
