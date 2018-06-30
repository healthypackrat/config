function! s:set_path()
  if !executable('ruby')
    return
  endif

  let std_paths = split(system('ruby -e "puts $:"'), '\n')
  let gem_paths = split(system('ruby -e "puts Gem.path.map {|s| s + %(/gems/*/lib) }"'), '\n')

  if !empty(findfile('Gemfile', ';'))
    let output = system('bundle show --paths')

    if v:shell_error is 0
      let gem_paths = map(split(output, '\n'), 'v:val . "/lib"')
    endif
  endif

  let &l:path = 'lib,,' . join(gem_paths + std_paths, ',')
endfunction

call s:set_path()
