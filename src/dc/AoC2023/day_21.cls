Class dc.AoC2023.day21 Extends dc.AoC2023.base
{

ClassMethod dfs(ByRef adj, ByRef vs, u) [ ProcedureBlock = 1 ]
{
  if ($d(vs(u), targ)) return targ
  set a = $p(adj(u), " "), op = $p(adj(u), " ", 2), b = $p(adj(u), " ", 3)
  set x = 0
  if (op = "+") {
    set x = ..dfs(.adj, .vs, a) + ..dfs(.adj, .vs, b)
  }
  if (op = "-") {
    set x = ..dfs(.adj, .vs, a) - ..dfs(.adj, .vs, b)
  }
  if (op = "*") {
    set x = ..dfs(.adj, .vs, a) * ..dfs(.adj, .vs, b)
  }
  if (op = "/") {
    set x = ..dfs(.adj, .vs, a) / ..dfs(.adj, .vs, b)
  }
  set vs(u) = x
  return x
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/21.in", .ls)
  set adj = 0
  set vs = ls
  for i=1:1:ls {
    set l = ls(i)
    set m = $p(l, ": "), exp = $p(l, ": ", 2)
    if (+exp = exp) {
      set vs(m) = exp
    } else {
      set adj(m) = exp, adj = adj + 1
    }
  }
  return ..dfs(.adj, .vs, "root")
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  #; notice it is monotonically dec so we can binary search
  d ..Read("/irisdev/app/inputs/2023/21.in", .ls)
  set adj = 0
  set vs = ls
  for i=1:1:ls {
    set l = ls(i)
    set m = $p(l, ": "), exp = $p(l, ": ", 2)
    if (+exp = exp) {
      set vs(m) = exp
    } else {
      set adj(m) = exp, adj = adj + 1
    }
  }
  kill adj("humn")
  set l = 1, r = 10000000000000
  set a = $p(adj("root"), " "), b = $p(adj("root"), " ", 3)
  while (l < r) {
    set m = (l + r + 1) \ 2
    kill vsc
    MERGE vsc = vs
    set vsc("humn") = m
    set left = ..dfs(.adj, .vsc, a), right = ..dfs(.adj, .vsc, b)
    if (left = right) {
      return m
    } elseif (left > right) {
      set l = m
    } else {
      set r = m - 1
    }
  }
  return -1
}

}
