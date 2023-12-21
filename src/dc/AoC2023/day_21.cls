Class dc.AoC2023.day21 Extends dc.AoC2023.base
{

ClassMethod Solve(ByRef g, T, sr, sc) [ ProcedureBlock = 1 ]
{
  set R = g, C = g(1)
  set seen = ""
  set DS(0) = 1, DS(1) = 0, DS(2) = -1, DS(3) = 0, DS(4) = 1

  set q = []
  do q.%Push(sr_" "_sc)
  set seen(sr, sc) = 0

  for t=1:1:T {
    set nq = []
    for i=0:1:q.%Size() - 1 {
      set u = q.%Get(i)
      set r = $p(u, " "), c = $p(u, " ", 2)

      for j=0:1:3 {
        set dr = DS(j), dc = DS(j + 1)
        set nr = r + dr, nc = c + dc

        if ((1 <= nr) && (nr <= R) && (1 <= nc) && (nc <= C) && (g(nr, nc) '= "#") && ('$d(seen(nr, nc)))) {
          set seen(nr, nc) = t
          do nq.%Push(nr_" "_nc)
        }
      }
    }
    set q = nq
  }
  
  set res = 0
  for r=1:1:R {
    for c=1:1:C {
      if ($d(seen(r, c), t) && ((t # 2) = (T # 2))) {
        set res = res + 1
      }
    }
  }
  return res
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/21.in", .ls)
  set g = ""
  d ..ToGrid(.g, .ls)
  return ..Solve(.g, 64, 66, 66)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/21.in", .ls)
  set T = 26501365
  set g = ""
  d ..ToGrid(.g, .ls)
  set R = g, C = g(1)
  set sr = 66, sc = 66
  set g(sr, sc) = "."
  set NR = 11 * R, NC = 11 * C
  set g = NR
  for rt=0:1:11 {
    for ct=0:1:11 {
      for r=1:1:R {
        for c=1:1:C {
          set nr = rt * R + r, nc = ct * C + c
          set g(nr, nc) = g(r, c)
          set g(nr) = NC
        }
      }
    }
  }

  set sr = sr + (6 * R), sc = sc + (6 * C)
  set f0 = ..Solve(.g, 0 * 131 + 65, sr, sc)
  set f1 = ..Solve(.g, 1 * 131 + 65, sr, sc)
  set f2 = ..Solve(.g, 2 * 131 + 65, sr, sc)
  // f(x) = ax^2 + bx + c
  // f(0) = c
  set c = f0
  // f(1) = a + b + c
  // f(2) = 4a + 2b + c 
  // f(1) - f(0) = a + b
  // f(2) - f(0) = 4a + 2b
  set f2minusf0 = f2 - c
  set f1minusf0 = f1 - c
  set a = (f2minusf0 - (2 * f1minusf0)) \ 2
  set b = f1minusf0 - a
  set x = T \ 131
  return (a * x * x) + (b * x) + c
}

}
