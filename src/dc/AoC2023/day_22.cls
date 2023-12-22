Class dc.AoC2023.day22 Extends dc.AoC2023.base
{

ClassMethod BuildGraph(ByRef ls, ByRef g, ByRef R, ByRef C) As %Status [ ProcedureBlock = 1 ]
{
  set blocks = ""
  set R = 0, C = 0

  for i=1:1:ls {
    set l = ls(i)
    set s = $p(l, "~"), e = $p(l, "~", 2)
    set R = ..Max(R, ..Max($p(e, ","), $p(s, ",")))
    set C = ..Max(C, ..Max($p(e, ",", 2), $p(s, ",", 2)))
    set key = $p(s, ",", 3)
    set blocks(key, i) = l
  }

  set heights = ""
  set carry = ""
  set cc = 0

  set key = ""
  for {
    set key = $o(blocks(key))
    if (key = "") {
      quit
    }
    set id = ""
    for {
      set id = $o(blocks(key, id), 1, targ)
      if (id = "") {
        quit
      }
      set mx = -1
      kill touched

      set a = $p(targ, "~"), b = $p(targ, "~", 2)
      set r1 = $p(a, ","), r2 = $p(b, ",")
      set c1 = $p(a, ",", 2), c2 = $p(b, ",", 2)
      for r=..Min(r1, r2):1:..Max(r1, r2) {
        for c=..Min(c1, c2):1:..Max(c1, c2) {
          if (($get(heights(r, c, "h"), 0) + 1) > mx) {
            set mx = $get(heights(r, c, "h"), 0) + 1
            kill touched
            set touched($get(heights(r, c, "id"), 0)) = ""
          } elseif (($get(heights(r, c, "h"), 0) + 1) = mx) {
            set touched($get(heights(r, c, "id"), 0)) = ""
          }
        }
      }

      set x = 0, c = 0
      for {
        set x = $o(touched(x))
        if (x = "") {
          quit
        }
        set g(x, id) = ""
        set c = c + 1
      }

      // only held up by 1 other block
      if (c = 1) {
        if ('$d(carry($o(touched(""))))) {
          set cc = cc + 1
        }
        set carry($o(touched(""))) = ""
        kill touched
      }

      if ($p(a, ",", 3) > mx) {
        set $p(b, ",", 3) = $p(b, ",", 3) - $p(a, ",", 3) + mx
        set $p(a, ",", 3) = mx 
      }

      set r1 = $p(a, ","), r2 = $p(b, ",")
      set c1 = $p(a, ",", 2), c2 = $p(b, ",", 2)
      set h1 = $p(a, ",", 3), h2 = $p(b, ",", 3)
      for r=..Min(r1, r2):1:..Max(r1, r2) {
        for c=..Min(c1, c2):1:..Max(c1, c2) {
          set heights(r, c, "h") = ..Max(h1, h2)
          set heights(r, c, "id") = id
        }
      }
    }
  }

  return ls - cc
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/22.in", .ls)
  set g = "" 
  return ..BuildGraph(.ls, .g, .R,.C)
}

ClassMethod Solve(ByRef g, ByRef ind, n, u) As %Status [ ProcedureBlock = 1 ]
{
  set q = []
  do q.%Push(u)
  set qi = 0

  set destroyed = 0
  while (qi < q.%Size()) {
    set u = q.%Get(qi)
    set qi = qi + 1
    set destroyed = destroyed + 1

    for v=1:1:n {
      if ($d(g(u, v))) {
        set ind(v) = ind(v) - 1
        if (ind(v) = 0) {
          do q.%Push(v)
        }
      }
    }
  }
  return destroyed - 1
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/22.in", .ls)
  d ..BuildGraph(.ls, .g, .R, .C)
  set res = 0, n = ls

  for u=1:1:n {
    for v=1:1:n {
      if ($d(g(u, v))) {
        set ind(v) = $g(ind(v), 0) + 1 
      }
    }
  }

  for u=1:1:ls {
    merge cind = ind
    set res = res + ..Solve(.g, .cind, n, u)
  }
  return res
}

}
