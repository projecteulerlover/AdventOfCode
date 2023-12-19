Class dc.AoC2023.day17 Extends dc.AoC2023.base
{

ClassMethod GetInputs(ByRef input, ByRef G, ByRef D, ByRef DIST) As %Status [ ProcedureBlock = 1 ]
{
  set G = input
  for i=1:1:input {
    set G(i) = $length(input(i))
    for j=1:1:G(i) {
      set G(i, j) = $e(input(i), j)
      for k=0:1:3 {
        set DIST(i, j, k) = 2**60
      }
    }
  }

  set D = 3
  set D(0) = 0
  set D(1) = 1
  set D(2) = 0
  set D(3) = -1
  set D(4) = 0
}

ClassMethod Solve(ByRef ls, mn, mx) As %Status [ ProcedureBlock = 1 ]
{
  set G = "", D = "", DIST = "", heap = ""
  do ..GetInputs(.ls, .G, .D, .DIST)
  
  set M = G, N = G(1)
  set heap(0, "1 1", 0) = ""
  set heap(0, "1 1", 1) = ""

  while ($d(heap)) {
    set d = $o(heap("")), pos = $o(heap(d, "")), dir = $o(heap(d, pos, ""))
    kill heap(d, pos, dir)
    set r = $p(pos, " "), c = $p(pos, " ", 2)

    if (d > DIST(r, c, dir)) {
      continue
    }

    if ((r = M) && (c = N)) {
      return d
    }
    for dd = -1:2:1 {
      set ndir = (dir + dd) # 4, nd = d
      for x=1:1:mx {
        set nr = r + (x * D(ndir)), nc = c + (x * D(ndir + 1))
        if ((nr < 1) || (nr > M) || (nc < 1) || (nc > N)) {
          quit
        }
        set nd = nd + G(nr, nc)
        if ((x >= mn) && (DIST(nr, nc, ndir) > nd)) {
          set DIST(nr, nc, ndir) = ..Min(DIST(nr, nc, ndir), nd)
          set heap(nd, nr_" "_nc, ndir) = "" 
        }
      }
    }
  }
  return -1
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/17.in", .ls)

  return ..Solve(.ls, 1, 3)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/17.in", .ls)

  return ..Solve(.ls, 4, 10)
}

}
