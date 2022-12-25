Class dc.AoC2022.day16 Extends dc.AoC2022.base
{

ClassMethod BuildGraph(ByRef flows, ByRef dists, ByRef n) [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/16.in", .ls)
  set flows = "", dists = "", compression("AA") = 0, id = 1
  for i=1:1:ls {
    set ls(i) = $replace(ls(i), "=", " ")
    set ls(i) = $replace(ls(i), ";", "")
    set ls(i) = $change(ls(i), ", ", " ")
    set c = $p(ls(i), " ", 2)
    if ((c '= "AA") && (+$p(ls(i), " ", 6) > 0)) set compression(c) = id, id = id + 1
  }
  set n = id
  for i=1:1:ls {
    set c = $p(ls(i), " ", 2)
    if ((c '= "AA") && (+$p(ls(i), " ", 6) = 0)) set compression(c) = id, id = id + 1
  }
  for i=1:1:ls {
    set flows(compression($p(ls(i), " ", 2))) = $p(ls(i), " ", 6)
    for j=11:1:$LENGTH(ls(i), " ") {
      set dists(compression($p(ls(i), " ", 2)), compression($p(ls(i), " ", j))) = 1
    }
  }
  for v=0:1:ls-1 {
    for u=0:1:ls-1 {
      for w=0:1:ls-1 {
        set dists(u, w) = ..Min($g(dists(u, w), 100), $g(dists(u, v), 100) + $g(dists(v, w), 100))
      }
    }
  }
}

ClassMethod dfs(u, t, opened, n, ByRef flows, ByRef dists, ByRef cache) [ ProcedureBlock = 1 ]
{
  if ($d(cache(u_" "_t_" "_opened), targ)) return targ
  set x = 0
  for v=0:1:n-1 {
    if (($ZBOOLEAN(opened, $ZPOWER(2, v), 1) = 0) || (dists(u, v) >= t) || (flows(v) = 0)) continue
    set arrival = t - 1 - dists(u, v)
    set x = ..Max(x, flows(v) * arrival + ..dfs(v, arrival, opened - $ZPOWER(2, v), n, .flows, .dists, .cache))
  }
  set cache(u_" "_t_" "_opened) = x
  return x
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  do ..BuildGraph(.flows, .dists, .n)
  return ..dfs(0, 30, $ZPOWER(2, n)-1, n, .flows, .dists, .cache)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  zw "This will take awhile"
  do ..BuildGraph(.flows, .dists, .n)
  set M = $ZPOWER(2, n)-1, msf = 0
  for mask=0:1:M {
    set msf = ..Max(msf, ..dfs(0, 26, mask, n, .flows, .dists, .cache) + ..dfs(0, 26, M - mask, n, .flows, .dists, .cache))
  }
  return msf
}

}
