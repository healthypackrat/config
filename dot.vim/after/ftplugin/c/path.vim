function! s:set_path()
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

  let paths = filter(map(lines[beg:end], 's:cleanup(v:val)'), 'isdirectory(v:val)')

  let &l:path = '.,' . join(paths, ',') . ',,'
endfunction

function! s:cleanup(str)
  return substitute(substitute(a:str, '(.\{-})$', '', ''), '^\s\+\|\s\+$', '', 'g')
endfunction

call s:set_path()
