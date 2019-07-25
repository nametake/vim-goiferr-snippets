scriptencoding utf-8

if exists('g:loaded_hellobeautifulworld')
    finish
endif
let g:loaded_ultisnipsgoiferr = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

function! goiferrsnippets#goiferr(err)
  let re_func = '\vfunc'
  let re_type = '%(%([.A-Za-z0-9*]|\[|\]|%(%(struct)|%(interface)\{\}))+)'
  let re_rcvr = '%(\s*\(\w+\s+' . re_type . '\))?'
  let re_name = '%(\s*\w+)?'
  let re_arg  = '\(%(\w+%(\s+%(\.\.\.)?' . re_type . ')?\s*,?\s*)*\)'

  let re_ret_v = '%(\w+)'
  let re_ret  = '%(\s*\(?(\s*\*?[a-zA-Z0-9_. ,]+)\)?\s*)?'
  let re_ret_body = '%(' . re_ret_v . '|%(' . re_ret_v  . '\s*' . re_type . ')|' . re_type . '\s*,?\s*)*'
  let re_ret  = '%(\s*\(?\s*(' . re_ret_body . ')\)?\s*)?'
  let re = re_func . re_rcvr . re_name . re_arg . re_ret . '\{'

  let lnum = line('.')
  let ret = ''
  while lnum > 0
    let lnum -= 1

    let ma = matchlist(getline(lnum), re)
    if len(ma) == 0
      continue
    endif
    let ret = ma[1]
    break
  endwhile

  if ret =~ '\v^\s*$'
    return '${0:return}'
  endif

  let rets = []
  for t in split(ret, ',')
    if t =~# '\v^\s*error\s*$'
      let v = a:err
    elseif t =~# '\v^\s*string\s*$'
      let v = '""'
    elseif t =~# '\v^\s*int\d*\s*$'
      let v = '0'
    elseif t =~# '\v^\s*bool\s*$'
      let v = 'false'
    else
      let v = 'nil'
    endif
    call add(rets, v)
  endfor

  return 'return ' . join(rets, ', ')
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
