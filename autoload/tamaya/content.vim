let s:animation_path = expand("<sfile>:p:h:h:h") . '/animation/'
let s:clones = {}

function! tamaya#content#init() abort
    let s:clones.length = 0
    for l:y in range(line("w0"),line("w$"))
        let s:clones[l:y] = getline(l:y)
        let s:clones.length += 1 
    endfor
endfunction

function! tamaya#content#new(name) abort
    let l:filelist = expand(s:animation_path . a:name .'/*')
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

function! tamaya#content#margin(content) abort
    let l:index = 0
    let l:lines = {}
    for l:key in sort(keys(s:clones))
        if l:index >= len(a:content)
            break
        endif
        let l:line = ''
        let l:merginsize = (winwidth(0) - len(a:content[l:index])) / 2 
        for l:x in range(l:merginsize)
            let l:char = s:clones[l:key][l:x] != "" ? s:clones[l:key][l:x] : " "
            let l:line = l:line . l:char
        endfor
        let l:lines[l:key] = l:line . a:content[l:index]
        let l:index += 1
    endfor
    return l:lines
endfunction

function! tamaya#content#loop(content) abort
    while 1
        for l:line in a:content
            for l:key in keys(l:line)
                call setline(l:key,l:line[l:key])
            endfor
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
    let l:contents = []
    for l:content in tamaya#content#new('firework')
        call add(l:contents,tamaya#content#margin(l:content))
    endfor

    call tamaya#content#loop(l:contents)

    call timer_pause(g:calltimer,0)
    for l:key in keys(s:clones)
        call setline(l:key,s:clones[l:key])
    endfor
endfunction
