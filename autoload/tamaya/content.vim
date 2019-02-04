function! tamaya#content#init() abort
    let s:clones = []

    for l:y in range(line("w0"),line("w$"))
        let l:clone = {}
        let l:clone.num = l:y
        let l:clone.line = getline(l:y)
        call add(s:clones,l:clone)
    endfor
endfunction

function! tamaya#content#new() abort
    let l:filelist = expand(expand("<sfile>:p:h") . '/animation/firework/*')
    let l:files = split(l:filelist,'\n')
    let l:contents = []
    for l:file in l:files
        let l:lines = []
        for l:line in readfile(l:file)
            call add(l:lines,l:line)
        endfor
        call add(l:contents,l:lines)
    endfor
    return l:contents
endfunction

function! tamaya#content#set(...) abort
    let l:contents = {"x":0,"y":0,"line":[],}
    let l:result = []
    

    if a:0 >= 1
        let l:contents = a:1
    endif

    for l:content in l:contents.line
        let l:lines = []
        for l:y in range(l:contents.y)
            call add(l:lines,'')
        endfor
        for l:c in l:content
            let l:line = l:c
            for l:x in range(l:contents.x)
                let l:line = ' ' . l:line
            endfor
            call add(l:lines,l:line)
        endfor
        call add(l:result,l:lines)
    endfor
    return l:result
endfunction

function! tamaya#content#animate(...) abort
    let l:contents = {"x":0,"y":0,"line":[]}

    if a:0 == 2
        let l:contents.x = a:1
        let l:contents.y = a:2
    endif

    for l:content in tamaya#content#new()
        let l:lines = []
        for l:line in l:content
            call add(l:lines,l:line)
        endfor
        call add(l:contents.line,l:lines)
    endfor

    while 1
        for l:r in l:contents.line
            call setline(1,l:r)
            let l:c = getchar(0)
            if l:c != 0
                break
            endif
            sleep 10m
            redraw!
        endfor
        if l:c != 0
            break
        endif
    endwhile
    call timer_pause(g:calltimer,0)
    for l:clone in s:clones
        call setline(l:clone.num,l:clone.line)
    endfor
endfunction
