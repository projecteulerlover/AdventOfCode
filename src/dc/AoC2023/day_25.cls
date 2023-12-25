Class dc.AoC2023.day25 Extends dc.AoC2023.base
{

ClassMethod MinCut(ByRef g) As %Status
{
  set fm = 0
  for u=0:1:g-1 {
    set q = []
    kill vs
    set vs(u) = ""
    do q.%Push(u)
    set qi = 0
    while (qi < q.%Size()) {
      set v = q.%Get(qi)
      set qi = qi + 1
      set w = ""
      for {
        set w = $o(g(v, w))
        if (w = "") {
          quit
        }
        if ($d(vs(w))) {
          continue
        }
        set vs(w) = ""
        set x = ..Min(v, w), y = ..Max(v, w)
        set fm(x, y) = $get(fm(x, y), 0) + 1
        do q.%Push(w)
      }
    }
  }
  set best = ""
  for u=0:1:g-1 {
    for v=u+1:1:g-1 {
      if ($d(fm(u, v), count)) {
        set best(count) = u_" "_v
      }
    }
  }
  set ind = ""
  for i=1:1:3 {
    set ind = $o(best(ind), -1, targ)
    set u = $p(targ, " "), v = $p(targ, " ", 2)
    kill g(u, v)
    kill g(v, u)
  }

  set q = []
  kill vs
  set vs(u) = "", vs = 1
  do q.%Push(u)
  set qi = 0
  while (qi < q.%Size()) {
    set v = q.%Get(qi)
    set qi = qi + 1
    set w = ""
    for {
      set w = $o(g(v, w))
      if (w = "") {
        quit
      }
      if ($d(vs(w))) {
        continue
      }
      set vs(w) = ""
      set vs = vs + 1
      do q.%Push(w)
    }
  }
  return vs * (g - vs)
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/25.in", .ls)
  set map = 0, adj = 0
  for i=1:1:ls {
    set l = ls(i)
    set u = $p(l, ": "), vs = $p(l, ": ", 2)
    if ('$d(map(u))) {
      set map(u) = map
      set map = map + 1
    }
    for j=1:1:$length(vs, " ") {
      set v = $p(vs, " ", j)
      if ('$d(map(v))) {
        set map(v) = map
        set map = map + 1
      }
      set adj(map(u), map(v)) = 1
      set adj(map(v), map(u)) = 1
    }
  }
  set adj = map
  return ..MinCut(.adj)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/25.in", .ls)
  return "happy holidays!"
}

}
