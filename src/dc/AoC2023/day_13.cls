Class dc.AoC2023.day13 Extends dc.AoC2023.base
{

ClassMethod CountDiffRow(ByRef G, r) As %Status [ ProcedureBlock = 1 ]
{
  set d = 0
  set M = G, N = G(1)
  
  for nr=1:1:r {
    set mr = 2 * r - nr + 1
    if (mr > M) {
      continue
    }
    for nc=1:1:N {
      if (G(nr, nc) '= G(mr, nc)) {
        set d = d + 1
      }
    }
  }

  return d
}

ClassMethod CountDiffCol(ByRef G, c) As %Status [ ProcedureBlock = 1 ]
{
  set d = 0
  set M = G, N = G(1)
  
  for nc=1:1:c {
    set mc = 2 * c - nc + 1
    if (mc > N) {
      continue
    }
    for nr=1:1:M {
      if (G(nr, nc) '= G(nr, mc)) {
        set d = d + 1
      }
    }
  }

  return d
}

ClassMethod Solve(ByRef G, diff = 0) As %Status [ ProcedureBlock = 1 ]
{
  set M = G, N = G(1)

  for r=1:1:M-1 {
    set d = ..CountDiffRow(.G, r)
    if (d = diff) {
      return 100 * r
    }
  }

  for c=1:1:N-1 {
    set d = ..CountDiffCol(.G, c)
    if (d = diff) {
      return c
    }
  }

  return -1
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/13.in", .ls, 1)

  set res = 0
  for k=1:1:ls {
    kill G
    set G = ls(k)
    for i=1:1:G {
      set G(i) = $length(ls(k, i))
      for j=1:1:G(i) {
        set G(i, j) = $e(ls(k, i), j)
      }
    }
    set res = res + ..Solve(.G, 0)
  }
  
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/13.in", .ls, 1)
  set res = 0
  for k=1:1:ls {
    kill G
    set G = ls(k)
    for i=1:1:G {
      set G(i) = $length(ls(k, i))
      for j=1:1:G(i) {
        set G(i, j) = $e(ls(k, i), j)
      }
    }
    set res = res + ..Solve(.G, 1)
  }

  return res
}

}
