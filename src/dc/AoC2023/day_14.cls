Class dc.AoC2023.day14 Extends dc.AoC2023.base
{

// ClassMethod Tilt(ByRef G) As %Status [ ProcedureBlock = 1 ]

// {

//   merge F = G

//   kill G

//   set G =

// }

ClassMethod Rotate(ByRef og, ByRef ng) As %Status [ ProcedureBlock = 1 ]
{
  set m = og, n = og(1)
  set ng = n
  for c=1:1:n {
    set ng(c) = m
    for r=1:1:m {
      set ng(c, m - r + 1) = og(r, c)
    }
  }
}

ClassMethod Tilt(ByRef g) As %Status [ ProcedureBlock = 1 ]
{
  set m = g, n = g(1)
  for c=1:1:n {
    set cr = 1
    for r=1:1:m {
      if (g(r, c) = "#") {
        set cr = r + 1
      } elseif (g(r, c) = "O") {
        set g(r, c) = "."
        set g(cr, c) = "O"
        set cr = cr + 1
      }
    }
  }
}

ClassMethod GetLoad(ByRef g) As %Status [ ProcedureBlock = 1 ]
{
  set m = g, n = g(1), res = 0
  for r=1:1:m {
    set count = 0
    for c=1:1:n {
      if (g(r, c) = "O") {
        set count = count + 1
      }
    }
    set res = res + ((m - r + 1) * count)
  }
  return res
}

ClassMethod Serialize(ByRef G) As %Status [ ProcedureBlock = 1 ]
{
  set state = ""
  for i=1:1:G {
    for j=1:1:G(i) {
      set state = state_G(i, j)
    }
    if (i '= G) {
      set state = state_" "
    }
  }
  return state
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/14.in", .ls)
  set g = ls
  for i=1:1:g {
    set g(i) = $length(ls(i))
    for j=1:1:g(i) {
      set g(i, j) = $e(ls(i), j)
    }
  }
  do ..Tilt(.g)
  return ..GetLoad(.g)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/14.in", .ls)

  set DP = ""
  set T = 1000000000
  set t = 1

  set g = ls
  for i=1:1:g {
    set g(i) = $length(ls(i))
    for j=1:1:g(i) {
      set g(i, j) = $e(ls(i), j)
    }
  }

  while (1) {
    for d=1:1:4 {
      do ..Tilt(.g)
      kill ng
      merge ng = g 
      kill g 
      do ..Rotate(.ng, .g)
    }
    set key = ..Serialize(.g)
    if ($d(DP(key), val)) {
      set prev = $p(val, " "), load = $p(val, " ", 2)
      set cycle = t - prev
      
      set cache = ""
      for {
        set cache = $o(DP(cache), 1, cacheval)
        if (cache = "") {
          quit
        }
        set jprev = $p(cacheval, " "), jload = $p(cacheval, " ", 2)
        if ((jprev >= prev) && ((jprev # cycle) = (T # cycle))) {
          return jload
        }
      }
    }
    set DP(key) = t_" "_..GetLoad(.g)
    set t = t + 1
  }

  return -1
}

}
