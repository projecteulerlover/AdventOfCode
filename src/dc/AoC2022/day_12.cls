Class dc.AoC2022.day12 Extends dc.AoC2022.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/12.in", .g)
  set m = g, n = $length(g(1))
  set d = 5, d(1) = 1, d(2) = 0, d(3) = -1, d(4) = 0, d(5) = 1, fr = 0, fc = 0
  set vs = 0
  set frontier = []
  for r=1:1:m {
    for c=1:1:n {
      if ($e(g(r), c) = "S") {
        set $e(g(r), c) = "a"
        set vs(r, c) = ""
        do frontier.%Push("a "_r_" "_c)
      } elseif ($e(g(r), c) = "E") {
        set fr = r, fc = c
        set $e(g(r), c) = "z"
      }
    }
  }
  set d = 1
  while (frontier.%Size() > 0) {
    set nf = []
    set iter = frontier.%GetIterator()
    while iter.%GetNext(.k, .v) {
      set x = $p(v, " "), r = $p(v, " ", 2), c = $p(v, " ", 3)
      for i=1:1:4 {
        set nr = r+d(i), nc = c + d(i+1)
        if ((1<=nr) && (nr<=m) && (1<=nc) && (nc<=n) && ($d(vs(nr, nc)) = 0) && ($ASCII($e(g(nr), nc)) - $ASCII(x) <= 1)) {
          if ((nr = fr) && (nc = fc)) return d
          do nf.%Push($e(g(nr), nc)_" "_nr_" "_nc)
          set vs(nr, nc) = ""
        }
      }
    }
    set frontier = nf
    set d = d + 1
  }
  return -1
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/12.in", .g)
  set m = g, n = $length(g(1))
  set d = 5, d(1) = 1, d(2) = 0, d(3) = -1, d(4) = 0, d(5) = 1, fr = 0, fc = 0
  set vs = 0
  set frontier = []
  for r=1:1:m {
    for c=1:1:n {
      if ($e(g(r), c) = "a") {
        do frontier.%Push("a "_r_" "_c)
        set vs(r, c) = ""
      } elseif ($e(g(r), c) = "E") {
        set fr = r, fc = c
        set $e(g(r), c) = "z"
      }
    }
  }
  set d = 1
  while (frontier.%Size() > 0) {
    set nf = []
    set iter = frontier.%GetIterator()
    while iter.%GetNext(.k, .v) {
      set x = $p(v, " "), r = $p(v, " ", 2), c = $p(v, " ", 3)
      for i=1:1:4 {
        set nr = r+d(i), nc = c + d(i+1)
        if ((1<=nr) && (nr<=m) && (1<=nc) && (nc<=n) && ($d(vs(nr, nc)) = 0) && ($ASCII($e(g(nr), nc)) - $ASCII(x) <= 1)) {
          if ((nr = fr) && (nc = fc)) return d
          do nf.%Push($e(g(nr), nc)_" "_nr_" "_nc)
          set vs(nr, nc) = ""
        }
      }
    }
    set frontier = nf
    set d = d + 1
  }
  return -1
}

}
