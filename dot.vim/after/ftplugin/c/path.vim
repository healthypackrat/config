function! s:setup()
  if !executable('clang')
    return
  endif

  let lines = split(system('clang -E -v - < /dev/null 2>&1'), '\n')

  let beg = index(lines, '#include <...> search starts here:')
  let end = index(lines, 'End of search list.')

  if beg == -1 || end == -1
    return
  endif

  let beg += 1
  let end -= 1

  let paths = filter(map(lines[beg:end], 's:sanitize(v:val)'), 'isdirectory(v:val)')

  let &l:path = '.,' . join(paths, ',') . ',,'

  if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= ' | '
  else
    let b:undo_ftplugin = ''
  endif

  let b:undo_ftplugin .= 'setlocal path<'
endfunction

function! s:sanitize(str)
  return substitute(substitute(a:str, '(.\{-})$', '', ''), '^\s\+\|\s\+$', '', 'g')
endfunction

call s:setup()
