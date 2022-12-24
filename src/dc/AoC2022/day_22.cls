Class dc.AoC2022.day22 Extends dc.AoC2022.base
{

ClassMethod GetGrid(ByRef grid, ByRef input) [ ProcedureBlock = 1 ]
{
  for r=1:1:input(1) {
    for c=1:1:$length(input(1, r)) {
      set p = $e(input(1, r), c)
      if ((p = ".") || (p = "#")) set grid(r-1, c-1) = p
    }
  }
}

ClassMethod GetSteps(ByRef steps, moves) [ ProcedureBlock = 1 ]
{
  set n = $length(moves), c = 0, index = 1
  for i=1:1:n {
    if (($ascii("0") <= $ascii($e(moves, i))) && ($ascii($e(moves, i)) <= $ascii("9"))) {
      set c = 10 * c + $e(moves, i)
    } else {
      set steps(index) = c_" "_$e(moves, i)
      set c = 0
      set index = index + 1
    }
  }
  set steps(index) = c_" "
  set steps = index
}

ClassMethod Teleport(ByRef r, ByRef c, di, ByRef grid) [ ProcedureBlock = 1 ]
{
  if (di = 0) {
    set nr = r, nc = 0
    while ('$d(grid(nr, nc))) {
      set nc = nc + 1
    }
    set c = nc
    return
  }
  if (di = 1) {
    set nr = 0, nc = c
    while ('$d(grid(nr, nc))) {
      set nr = nr + 1
    }
    set r = nr
    return
  }
  if (di = 2) {
    set nr = r, nc = 149
    while ('$d(grid(nr, nc))) {
      set nc = nc - 1
    }
    set c = nc
    return
  }
  if (di = 3) {
    set nr = 199, nc = c
    while ('$d(grid(nr, nc))) {
      set nr = nr - 1
    }
    set r = nr
    return
  }
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2022/22.in", .ls, 1)
  do ..GetGrid(.grid, .ls)
  do ..GetSteps(.steps, ls(2, 1))
  set ds(0) = "0 1", ds(1) = "1 0", ds(2) = "0 -1", ds(3) = "-1 0"
  set di = 0, r = 0, c = 0
  while 1 {
    if ($d(grid(r, c), targ) && (targ = ".")) quit
    set c = c + 1
  }
  for s=1:1:steps {
    set n = $p(steps(s), " ")
    for z=1:1:n {
      set nr = r + $p(ds(di), " "), nc = c + $p(ds(di), " ", 2)
      if ('$d(grid(nr, nc))) do ..Teleport(.nr, .nc, di, .grid)
      if (grid(nr, nc) = ".") set r = nr, c = nc
    }
    set d = $p(steps(s), " ", 2)
    if (d = "R") {
      set di = (di + 1) # 4
    } elseif (d = "L") {
      set di = (di + 3) # 4
    }
  }

  return (1000 * (r+1)) + (4 * (c+1)) + di
}

ClassMethod CrossFace(ByRef r, ByRef c, ByRef di) [ ProcedureBlock = 1 ]
{
  set pr = r, pc = c, pdi = di
  if (pdi = 0) {
    if (pr \ 50 = 0) {
      set r = 149 - pr, c = 99, di = 2
      return
    }
    if (pr \ 50 = 1) {
      set r = 49, c = pr + 50, di = 3
      return
    }
    if (pr \ 50 = 2) {
      set r = 149 - pr, c = 149, di = 2
      return
    }
    if (pr \ 50 = 3) {
      set r = 149, c = pr - 100, di = 3
      return
    }
  }
  if (pdi = 1) {
    if (pc \ 50 = 0) {
      set r = 0, c = pc + 100, di = 1
      return
    }
    if (pc \ 50 = 1) {
      set r = 100 + pc, c = 49, di = 2
      return
    }
    if (pc \ 50 = 2) {
      set r = pc - 50, c = 99, di = 2
      return
    }
  }
  if (pdi = 2) {
    if (pr \ 50 = 0) {
      set r = 149 - pr, c = 0, di = 0
      return
    }
    if (pr \ 50 = 1) {
      set r = 100, c = pr - 50, di = 1
      return
    }
    if (pr \ 50 = 2) {
      set r = 149 - pr, c = 50, di = 0
      return
    }
    if (pr \ 50 = 3) {
      set r = 0, c = pr - 100, di = 1
      return
    }
  }
  if (pdi = 3) {
    if (pc \ 50 = 0) {
      set r = 50 + pc, c = 50, di = 0
      return
    }
    if (pc \ 50 = 1) {
      set r = 100 + pc, c = 0, di = 0
      return
    }
    if (pc \ 50 = 2) {
      set r = 199, c = pc - 100, di = 3
      return
    }
  }
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2022/22.in", .ls, 1)
  do ..GetGrid(.grid, .ls)
  do ..GetSteps(.steps, ls(2, 1))
  set ds(0) = "0 1", ds(1) = "1 0", ds(2) = "0 -1", ds(3) = "-1 0"
  set di = 0, r = 0, c = 0
  while 1 {
    if ($d(grid(r, c), targ) && (targ = ".")) quit
    set c = c + 1
  }
  for s=1:1:steps {
    set n = $p(steps(s), " ")
    for z=1:1:n {
      set nr = r + $p(ds(di), " "), nc = c + $p(ds(di), " ", 2), ndi = di
      if ('$d(grid(nr, nc))) do ..CrossFace(.nr, .nc, .ndi)
      if (grid(nr, nc) = ".") set r = nr, c = nc, di = ndi
    }
    set d = $p(steps(s), " ", 2)
    if (d = "R") {
      set di = (di + 1) # 4
    } elseif (d = "L") {
      set di = (di + 3) # 4
    }
  }

  return (1000 * (r+1)) + (4 * (c+1)) + di
}

}
