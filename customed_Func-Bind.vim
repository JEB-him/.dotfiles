function! OpenFileUnderCursor()
  " 先尝试获得 visual 选区的文本
  let l:filepath = GetVisualSelection()
  if l:filepath == ''
    " 如果没有选中区域，就获取光标下的文件路径
    let l:filepath = expand('<cfile>')
  endif

  if !empty(l:filepath)
    execute 'edit' fnameescape(l:filepath)
  else
    echo "File Not Found!"
  endif
endfunction

function! GetVisualSelection() abort
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  normal! gv"zy
  let l:selection = getreg('z')
  call setreg('"', l:old_reg, l:old_regtype)
  return l:selection
endfunction

nnoremap <leader>e :call OpenFileUnderCursor()<CR>
vnoremap <leader>e :<C-u>call OpenFileUnderCursor()<CR>
