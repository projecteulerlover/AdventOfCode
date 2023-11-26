Class dc.AoC2022.day8 Extends dc.AoC2022.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/8.in", .input, 2)
  set dir(1) = 1, dir(2) = 0, dir(3) = -1, dir(4) = 0, dir(5) = 1
  set res = 0, m = input, n = input(1)
  for r=1:1:m {
    for c=1:1:n {
      set ok = 1
      for i=1:1:4 {        
        set ok = 1
        set nr = r+dir(i), nc = c+dir(i+1)
        while ((1 <= nr) && (nr <= m) && (1 <= nc) && (nc <= n)) {
          if (input(nr, nc) >= input(r, c)) {
            set ok = 0
            quit
          }
          set nr = nr+dir(i), nc = nc+dir(i+1)
        }
        if (ok) quit
      }
      set res = res + ok
    }
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/8.in", .input, 2)
  set dir(1) = 1, dir(2) = 0, dir(3) = -1, dir(4) = 0, dir(5) = 1
  set msf = 0, m = input, n = input(1)
  for r=1:1:m {
    for c=1:1:n {
      set curr = 1
      for i=1:1:4 {
        set nr = r+dir(i), nc = c+dir(i+1), v = 0
        while ((1 <= nr) && (nr <= m) && (1 <= nc) && (nc <= n)) {
          set v = v+1
          if (input(nr, nc) >= input(r, c)) quit
          set nr = nr+dir(i), nc = nc+dir(i+1)
        }
        set curr = curr * v
      }
      set msf = ..Max(msf, curr)
    }
  }
  return msf
}

}
