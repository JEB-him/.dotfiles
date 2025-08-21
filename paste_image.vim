function! SaveAndInsertImage()
    let output = systemlist('~/.dotfiles/scripts/save_image_in_clip.sh')[0]
    if v:shell_error == 1
        echohl ErrorMsg
        echo "Error: " . output
        echohl None
    else
        echohl Directory
        echo output
        echohl None
        let output = substitute(output, " ", "", "g")
        let parts = split(output, "/")
        let filename = parts[-1]
        execute 'normal i!['.filename.'](./images/'.filename.')'
    endif
endfunction

nnoremap <silent> <C-p> :call SaveAndInsertImage()<CR>
