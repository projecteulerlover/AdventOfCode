Class dc.AoC2023.day25 Extends dc.AoC2023.base
{

ClassMethod MinCut(ByRef g) As %Status
{
  set best = 1e9
  set res = 0
  set n = g

  for i=0:1:n - 1 {
    set co(i) = 1, co(i, 0) = i
  }
  for j=1:1:n - 1 {
    if ((j # 50) = 0) {
      zw j_" out of "_(n - 1)_" done"
      zw res * (n - res)
    }
    kill w
    merge w = g(0)
    set s = 0, t = 0

    for k=0:1:n - j - 1 {
      set w(t) = -1e9
      set s = t, t = ..MaxInd(.w, n)
      for l=0:1:n - 1 {
        set w(l) = w(l) + g(t, l)
      }
    }
    if (best > (w(t) - g(t, t))) {
      set best = (w(t) - g(t, t))
      kill res
      merge res = co(t)
    } elseif (best = (w(t) - g(t, t))) {
      set replace = -1
      for k=0:1:..Min(res, co(t)) - 1 {
        if (res(k) < co(t, k)) {
          set replace = 0
          quit
        }
        if (res(k) > co(t, k)) {
          set replace = 1
          quit
        }
      }
      if (replace = -1) {
        set replace = res > co(t)
      }
      if (replace = 1) {
        kill res
        merge res = co(t)
      }
    }
    if ((res * (n - res)) > (n - 1)) {
      quit;
    }
    for k=0:1:co(t) - 1 {
      set co(s, co(s)) = co(t, k)
      set co(s) = co(s) + 1
    }
    for k=0:1:n - 1 {
      set g(s, k) = g(s, k) + g(t, k)
    }
    for k=0:1:n - 1 {
      set g(k, s) = g(s, k)
    }
    set g(0, t) = -1e9
  }
  return res * (n - res)
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/25.in", .ls)
  zw "Min cut will take awhile..."
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
  for i=0:1:adj - 1 {
    set adj(i) = adj
    for j = 0:1:adj - 1 {
      if ('$d(adj(i, j))) {
        set adj(i, j) = 0
      }
    }
  }
  return ..MinCut(.adj)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/25.in", .ls)
  return "happy holidays!"
}

}
