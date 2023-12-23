Class dc.AoC2023.day23 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/23.in", .ls)
  d ..ToGrid(.g, .ls)
  set DS(0) = 1, DS(1) = 0, DS(2) = -1, DS(3) = 0, DS(4) = 1
  set tiles("v") = 0, tiles("<") = 1, tiles("^") = 2, tiles(">") = 3

  set sc = 0, ec = 0
  set m = g, n = g(1)
  for c=1:1:n {
    if g(1, c) = "." {
      set sc = c 
    }
  }

  set q = []
  set qi = 0, res = 0
  do q.%Push(1_" "_sc_" 0 0 0")
  while (qi < q.%Size()) {
    set x = q.%Get(qi)
    set qi = qi + 1
    set r = $p(x, " "), c = $p(x, " ", 2), pr = $p(x, " ", 3), pc = $p(x, " ", 4), d = $p(x, " ", 5)
    
    if ((r = m)) {
      set res = ..Max(res, d)
    }

    if (g(r, c) = ".") {
      for i=0:1:3 {
        set nr = r + DS(i), nc = c + DS(i + 1)
        if ((1 <= nr) && (nr <= m) && (1 <= nc) && (nc <= n) && ((nr '= pr) || (nc '= pc)) && (g(nr, nc) '= "#")) {
          do q.%Push(nr_" "_nc_" "_r_" "_c_" "_(d + 1))
        }
      }
    } elseif ($d(tiles(g(r, c)), i)) {
      set nr = r + DS(i), nc = c + DS(i + 1)
      if ((1 <= nr) && (nr <= m) && (1 <= nc) && (nc <= n) && ((nr '= pr) || (nc '= pc)) && (g(nr, nc) '= "#")) {
        do q.%Push(nr_" "_nc_" "_r_" "_c_" "_(d + 1))
      }
    }
  }
  return res
}

ClassMethod BackTrack(ByRef g, ByRef DS, ByRef mx, r, c, d) As %Status [ ProcedureBlock = 1 ]
{
  set m = g, n = g(1)
  if (r = m) {
    set mx = ..Max(mx, d)
  }
  set g(r, c) = "#"
  for i=0:1:3 {
    set nr = r + DS(i), nc = c + DS(i + 1)
    if ((1 <= nr) && (nr <= m) && (1 <= nc) && (nc <= n) && (g(nr, nc) '= "#")) {
      do ..BackTrack(.g, .DS, .mx, nr, nc, d + 1)
    }
  }
  set g(r, c) = "."
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/23.in", .ls)

  for i=1:1:ls {
    set ls(i) = $TRANSLATE(ls(i), "^><v", "....")
  }

  d ..ToGrid(.g, .ls)
  set DS(0) = 1, DS(1) = 0, DS(2) = -1, DS(3) = 0, DS(4) = 1

  set sc = 0
  set m = g, n = g(1)
  for c=1:1:n {
    if g(1, c) = "." {
      set sc = c 
      quit
    }
  }

  set q = []
  set res = 0
  do q.%Push("1 "_sc_" 0")
  while (q.%Size()) {
    set x = q.%Pop()
    set r = $p(x, " "), c = $p(x, " ", 2), d = $p(x, " ", 3)
    if ((r = m)) {
      if (res < d) {
        set res = d
        zw res
      }
    }

    if (d = "") {
      set g(r, c) = "."
      continue
    }

    if ($d(g(r, c), v) && (v = "#")) {
      continue
    }

    set g(r, c) = "#"
    do q.%Push(r_" "_c_" ")
    for i=0:1:3 {
      set nr = r + DS(i), nc = c + DS(i + 1)
      if ((1 <= nr) && (nr <= m) && (1 <= nc) && (nc <= n) && (g(nr, nc) = ".")) {
        do q.%Push(nr_" "_nc_" "_(d + 1))
      }
    }
  }
  return res
}

}
