" vim: set ts=2 sts=2 sw=2

"if !get(g:, 'cwd_loaded', 0)
  "finish
"endif

let s:spc = g:airline_symbols.space

function! airline#extensions#alpaca_tags#init(ext)
  call airline#parts#define_raw('alpaca_tags', '%{airline#extensions#alpaca_tags#status()}')
  call a:ext.add_statusline_func('airline#extensions#alpaca_tags#apply')
endfunction

function! airline#extensions#alpaca_tags#apply(...)
  call airline#extensions#append_to_section('x',
        \ s:spc . g:airline_right_sep . s:spc . '%{airline#extensions#alpaca_tags#status()}')
endfunction

function! airline#extensions#alpaca_tags#status()
  "if (!get(g:, 'alpaca_tags#disable', 1) || g:alpaca_tags#disable == 1)
  "    return ''
  "endif
  let processes = alpaca_tags#process_manager#status()
  let status_str = ''
  let i = 0
  for [path, process] in items(processes)
     "let status_str .= substitute(getcwd(), '\v\w\zs.{-}\ze(\\|/)', '', 'g') . ':' . process.status()
     "let status_str .= fnamemodify(path, ":t") . ':' . process.status()
     let status_str .= process.status()
     if i == len(processes)
         let status_str .= '/'
     endif
     let i += 1
  endfor
  return status_str
endfunction

