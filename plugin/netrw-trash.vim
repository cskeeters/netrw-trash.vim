if get(g:, 'loaded_netrw_trash', 0) == 1
    finish
endif
let g:loaded_netrw_trash = 1

echom "loading"

" our custom delete routine
function! g:NetrwDoTrash(flist)
    echom 'Deleting ' a:flist
endfunction

" setup netrw mappings (:h g:Netrw_UserMaps)
let g:Netrw_UserMaps = [['T', 'g:netrw_trash']]

" implement normal mode deletion
function! g:netrw_trash(islocal)
    if a:islocal
        " get selected file list (:h netrw-mf)
        let l:flist = netrw#Expose('netrwmarkfilelist')
        if l:flist is# 'n/a'
            " no selection -- get name under cursor
            let l:flist = [b:netrw_curdir . '/' . netrw#GX()]
        else
            " remove selection as files will be deleted soon
            call netrw#Call('NetrwUnmarkAll')
        endif

        call g:NetrwDoTrash(l:flist)

        " Returning refresh tells netrw that it needs to refresh
        return 'refresh'
    else
        echom "netrw-trash does not handle remote trashing"
    endif
 endfunction

" vim: et ts=4 sts=4 sw=4
