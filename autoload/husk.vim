function! husk#abstract_left(command)
  let line = getcmdline()
  let pos = getcmdpos()
  let next = 1
  let nextnext = 1
  let i = 2
  while nextnext < pos
    let next = nextnext
    let nextnext = match(line, '[\/ ]\+\zs.\|^\|$', 0, i) + 1
    let i += 1
  endwhile
  return repeat(a:command, pos - next)
endfunction

function! husk#abstract_right(command)
  let line = getcmdline()
  let pos = getcmdpos()
  let next = 1
  let i = 2
  while next <= pos && next > 0
    let next = match(line, '[\/ ]\+\|^\|$', 0, i) + 1
    let i += 1
  endwhile
  return repeat(a:command, next - pos)
endfunction

function! husk#left()
  return husk#abstract_left("\<Left>")
endfunction

function! husk#right()
  return husk#abstract_right("\<Right>")
endfunction

function! husk#bs_word()
  return husk#abstract_left("\<BS>")
endfunction

function! husk#del_word()
  return husk#abstract_right("\<Right>\<BS>")
endfunction

function! husk#clear_line_after_cursor()
  let pos = getcmdpos()
  let line_len = strlen(getcmdline())
  return repeat("\<Del>", line_len - pos + 1)
endfunction
