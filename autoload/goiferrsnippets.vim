scriptencoding utf-8

if exists('g:loaded_hellobeautifulworld')
    finish
endif
let g:loaded_ultisnipsgoiferr = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

" regrex
let s:re_func = '\vfunc'
let s:re_type = '%(%([.A-Za-z0-9*]|\[|\]|%(%(struct)|%(interface)\{\}))+)'
let s:re_rcvr = '%(\s*\(\w+\s+' . s:re_type . '\))?'
let s:re_name = '%(\s*\w+)?'
let s:re_arg  = '\(%(\w+%(\s+%(\.\.\.)?' . s:re_type . ')?\s*,?\s*)*\)'

let s:re_ret_v = '%(\w+)'
let s:re_ret  = '%(\s*\(?(\s*\*?[a-zA-Z0-9_. ,]+)\)?\s*)?'
let s:re_ret_body = '%(' . s:re_ret_v . '|%(' . s:re_ret_v  . '\s*' . s:re_type . ')|' . s:re_type . '\s*,?\s*)*'
let s:re_ret  = '%(\s*\(?\s*(' . s:re_ret_body . ')\)?\s*)?'
let s:re = s:re_func . s:re_rcvr . s:re_name . s:re_arg . s:re_ret . '\{'

" get return types
function GetRet()
  let lnum = line('.')
  let ret = ''
  while lnum > 0
    let lnum -= 1

    let ma = matchlist(getline(lnum), s:re)
    if len(ma) == 0
      continue
    endif
    let ret = ma[1]
    break
  endwhile
  return ret
endfunction

function! goiferrsnippets#goiferr(err)
  let ret = GetRet()

  " no return value
  if ret =~# '\v^\s*$'
    return '${0:return}'
  endif

  " named return values
  if ret =~# '\v^\w* \*?\w*'
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
    elseif t =~# '\v^\s*\*.*$' " pointer
      let v = 'nil'
    else
      let v = trim(t) . '{}'
    endif
    call add(rets, v)
  endfor

  return 'return ' . join(rets, ', ')
endfunction

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
