Class dc.AoC2023.day16 Extends dc.AoC2023.base
{

ClassMethod Push(ByRef frontier, ByRef vs, M, N, r, c, d) As %Status [ ProcedureBlock = 1 ]
{
  if ((1 <= r) && (r <= M) && (1 <= c) && (c <= N) && '$d(vs(r, c, d))) {
    set vs(r, c, d) = ""
    do frontier.%Push(r_" "_c_" "_d)
  }
}

ClassMethod Solve(ByRef g, r, c, dir) As %Status [ ProcedureBlock = 1 ]
{
  set M = g, N = $length(g(1))
  set d(1) = 1, d(2) = 0, d(3) = -1, d(4) = 0, d(5) = 1
  set D(1) = 4, D(2) = 3, D(3) = 2, D(4) = 1
  set E(1) = 2, E(2) = 1, E(3) = 4, E(4) = 3
  set vs = 0
  set frontier = []
  do frontier.%Push(r_" "_c_" "_dir)

  while (frontier.%Size() > 0) {
    set nf = []
    set iter = frontier.%GetIterator()
    while iter.%GetNext(.k, .v) {
      set r = $p(v, " "), c = $p(v, " ", 2), dir = $p(v, " ", 3)
      if ((r = 0) || (r = (M + 1)) || (c = 0) || (c = (N + 1))) {
        set tile = "."
      } else {
        set tile = $e(g(r), c)
      }

      if (((dir = 1) || (dir = 3)) && (tile = "-")) {
        set nr = r + d(2), nc = c + d(3)
        do ..Push(.nf, .vs, M, N, nr, nc, 2)
        set nr = r + d(4), nc = c + d(5)
        do ..Push(.nf, .vs, M, N, nr, nc, 4)
        continue
      }

      if (((dir = 2) || (dir = 4)) && (tile = "|")) {
        set nr = r + d(1), nc = c + d(2)
        do ..Push(.nf, .vs, M, N, nr, nc, 1)
        set nr = r + d(3), nc = c + d(4)
        do ..Push(.nf, .vs, M, N, nr, nc, 3)
        continue
      }

      if (tile = "\") {
        set nr = r + d(dir + 1), nc = c + d(dir)
        do ..Push(.nf, .vs, M, N, nr, nc, D(dir))
        continue
      }

      if (tile = "/") {
        set nr = r - d(dir + 1), nc = c - d(dir)
        do ..Push(.nf, .vs, M, N, nr, nc, E(dir))
        continue
      }

      set nr = r + d(dir), nc = c + d(dir + 1)
      do ..Push(.nf, .vs, M, N, nr, nc, dir)
    }
    set frontier = nf
  }

  set res = 0, r = ""
  for {
    set r = $o(vs(r))
    if (r = "") {
      quit
    }
    set c = ""
    for {
      set c = $o(vs(r, c))
      if (c = "") {
        quit
      }
      set res = res + 1
    }
  }

  return res
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/16.in", .g)

  return ..Solve(.g, 1, 0, 4)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/16.in", .g)
  set res = 0
  set M = g, N = $length(g(1))

  for r=1:1:M {
    set res = ..Max(res, ..Solve(.g, r, 0, 4))
    set res = ..Max(res, ..Solve(.g, r, N + 1, 2))
  }
  
  for c=1:1:N {
    set res = ..Max(res, ..Solve(.g, 0, c, 1))
    set res = ..Max(res, ..Solve(.g, M + 1, c, 3))
  }

  return res
}

}
