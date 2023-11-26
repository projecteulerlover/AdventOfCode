Class dc.AoC2022.day24 Extends dc.AoC2022.base
{

ClassMethod IsBoundary(m, n, x, y) [ ProcedureBlock = 1 ]
{
  if (((x = 0) && (y = 1)) || ((m-1 = x) && (n-2 = y))) return 0
  return ((x = 0) || (y = 0) || (m-1 = x) || (n-1 = y))
}

ClassMethod GetBoard(ByRef m, ByRef n, ByRef blizz, ByRef T) [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/24.in", .ls)
  set m = ls, n = $length(ls(1)), T = (m-2) * (n-2)
  for i=1:1:m {
    for j=1:1:n {
      set c = $e(ls(i), j)
      set d = $case(c, ">":0, "v":1, "<":2, "^":3, :-1)
      if (d '= -1) set blizz((i-1)_" "_(j-1), d) = ""
    }
  }
} 

ClassMethod MoveBlizz(m, n, ByRef blizz) [ ProcedureBlock = 1 ]
{
  set p = ""
  set ds(0) = "0 1", ds(1) = "1 0", ds(2) = "0 -1", ds(3) = "-1 0"
  for {
    set p = $o(blizz(p))
    if (p = "") quit
    set d = "", x = $p(p, " "), y = $p(p, " ", 2)
    for {
      set d = $o(blizz(p, d))
      if (d = "") quit

      set dx = $p(ds(d), " "), dy = $p(ds(d), " ", 2)
      set nx = x + dx, ny = y + dy
      if (..IsBoundary(m, n, nx, ny)) {
        if (d = 0) {
          set ny = 1
        } elseif (d = 1) {
          set nx = 1
        } elseif (d = 2) {
          set ny = n-2
        } elseif (d = 3) {
          set nx = m-2
        }
      }
      set nblizz(nx_" "_ny, d) =  ""
    }
  }
  kill blizz
  MERGE blizz = nblizz
}

ClassMethod bfs(x, y, tx, ty, t, m, n, T, ByRef blizz) [ ProcedureBlock = 1 ]
{
  set q(x_" "_y) = "", cache(x, y, t) = ""
  set ds(0) = "0 1", ds(1) = "1 0", ds(2) = "0 -1", ds(3) = "-1 0"
  while ($d(q)) {
    do ..MoveBlizz(m, n, .blizz)
    kill nq
    set coord = "", t = t + 1, tt = t # T, nq = ""
    for {
      set coord = $o(q(coord))
      if (coord = "") quit
      set x = $p(coord,  " "), y = $p(coord, " ", 2)
      if ('$d(cache(x, y, t)) && '$d(blizz(x_" "_y))) {
        set nq(x_" "_y) = ""
        set cache(x, y, tt) = ""
      }
      for i=0:1:3 {
        set dx = $p(ds(i), " "), dy = $p(ds(i), " ", 2)
        set nx = x+dx, ny = y+dy
        if ('$d(cache(nx, ny, tt)) && '$d(blizz(nx_" "_ny)) && (0<=nx) && (nx<m) && (0<=ny) && (ny<n) && '..IsBoundary(m, n, nx, ny)) {
          if ((tx = nx) && (ty = ny)) return t
          set nq(nx_" "_ny) = "", cache(nx, ny, tt) = ""
        }
      }
    }

    kill q
    MERGE q = nq
  }
  return -1
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  do ..GetBoard(.m, .n, .blizz, .T)
  return ..bfs(0, 1, m-1, n-2, 0, m, n, T, .blizz)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  do ..GetBoard(.m, .n, .blizz, .T)
  set t1 = ..bfs(0, 1, m-1, n-2, 0, m, n, T, .blizz)
  set t2 = ..bfs(m-1, n-2, 0, 1, t1, m, n, T, .blizz)
  return ..bfs(0, 1, m-1, n-2, t2, m, n, T, .blizz)
}

}
