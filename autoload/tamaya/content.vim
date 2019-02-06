function! tamaya#content#init() abort
    let s:clones = []

    for l:y in range(line("w0"),line("w$"))
        let l:clone = {}
        let l:clone.num = l:y
        let l:clone.line = getline(l:y)
        call add(s:clones,l:clone)
    endfor
endfunction

function! tamaya#content#new(name) abort
    let l:filelist = expand(expand("<sfile>:p:h") . '/animation/'. a:name .'/*')
    let l:files = split(l:filelist,'\n')
    let l:contents = []
    for l:file in l:files
        let l:lines = []       
        for l:line in readfile(l:file)
            let l:line = substitute(l:line,'^\s*','','g')
            let l:line = substitute(l:line,'\s*$','','g')
            call add(l:lines,l:line)
        endfor
        call add(l:contents,l:lines)
    endfor
    return l:contents
endfunction

function! tamaya#content#margin(line,index) abort
    let l:line = ''
    echo len(a:line)
    let l:merginsize = (winwidth(0) - len(a:line)) / 2
    for l:x in range(l:merginsize)
        let l:char = s:clones[a:index].line[l:x] != "" ? s:clones[a:index].line[l:x] : " "
        let l:line = l:line . l:char 
    endfor
    return l:line . a:line
endfunction

function! tamaya#content#loop(content) abort
    while 1
        for l:line in a:content
            call setline(1,l:line)
            redraw!
            let l:char = getchar(0)
            if l:char != 0
                break
            endif
            sleep 10m
        endfor
        if l:char != 0
            break
        endif
    endwhile
endfunction

function! tamaya#content#line() abort

endfunction

function! tamaya#content#animate(...) abort
    let l:tmp = []
    for l:content in tamaya#content#new('firework')
        let l:lines = []
        let l:index = 0
        for l:line in l:content
            call add(l:lines,tamaya#content#margin(l:line,l:index))
            let l:index = l:index + 1
        endfor
        call add(l:tmp,l:lines)
    endfor

    call tamaya#content#loop(l:tmp)

    call timer_pause(g:calltimer,0)
    for l:clone in s:clones
        call setline(l:clone.num,l:clone.line)
    endfor
endfunction
