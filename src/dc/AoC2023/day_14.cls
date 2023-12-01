Class dc.AoC2023.day14 Extends dc.AoC2023.base
{

ClassMethod GetBarrier(ByRef barrier) As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/14.in", .ls)
  set barrier = 0
  for i=1:1:ls {
    set l = $replace(ls(i), " -> ", " ")
    set px = $p($p(l, " "), ","), py= $p($p(l, " "), ",", 2)
    set barrier = ..Max(barrier, py)
    for j=2:1:$LENGTH(l, " ") {
      set cx = $p($p(l, " ", j), ","), cy= $p($p(l, " ", j), ",", 2)
      if (cx = px) {
        set sy = ..Min(py, cy), ey = ..Max(py, cy)
        for y=sy:1:ey {
          set barrier(cx, y) = ""
        }
      }
      if (cy = py) {
        set sx = ..Min(px, cx), ex = ..Max(px, cx)
        for x=sx:1:ex {
          set barrier(x, cy) = ""
        }
      }
      set barrier = ..Max(barrier, cy)
      set px = cx, py = cy
    }
  }
  return 1
}

ClassMethod Drop(x, y, ByRef barrier, ByRef stop) [ ProcedureBlock = 1 ]
{
  if (y = barrier) {
    set stop = 1
    return
  }
  if ('$d(barrier(x, y+1))) {
    do ..Drop(x, y+1, .barrier, .stop)
    return
  }
  if ('$d(barrier(x-1, y+1))) {
    do ..Drop(x-1, y+1, .barrier, .stop)
    return
  }
  if ('$d(barrier(x+1, y+1))) {
    do ..Drop(x+1, y+1, .barrier, .stop)
    return
  }
  set barrier(x, y) = ""
}

ClassMethod Drop2(x, y, ByRef barrier) [ ProcedureBlock = 1 ]
{
  if ($d(barrier(x, y))) return
  if (y+1 = barrier) {
    set barrier(x, y) = ""
    return
  }
  if ('$d(barrier(x, y+1))) {
    do ..Drop2(x, y+1, .barrier)
    return
  }
  if ('$d(barrier(x-1, y+1))) {
    do ..Drop2(x-1, y+1, .barrier)
    return
  }
  if ('$d(barrier(x+1, y+1))) {
    do ..Drop2(x+1, y+1, .barrier)
    return
  }
  set barrier(x, y) = ""
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  do ..GetBarrier(.barrier)
  set res = 0, stop = 0
  while (stop = 0) {
    do ..Drop(500, 0, .barrier, .stop)
    if (stop = 0) set res = res + 1
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  do ..GetBarrier(.barrier)
  set barrier = barrier + 2
  set res = 0
  while ('$d(barrier(500, 0))) {
    do ..Drop2(500, 0, .barrier)
    set res = res + 1
  }
  return res
}

}
