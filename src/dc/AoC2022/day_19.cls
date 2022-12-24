Class dc.AoC2022.day19 Extends dc.AoC2022.base
{

ClassMethod dfs(ByRef cache, ByRef bp, r1, r2, r3, r4, o1, o2, o3, o4, mo1, t = 24) [ ProcedureBlock = 1 ]
{
  set no1 = o1 + r1, no2 = o2 + r2, no3 = o3 + r3, no4 = o4 + r4
  if (t = 1) return no4
  if ($d(cache(r1, r2, r3, r3, o1, o2, o3, o4, t), targ)) return targ
  #; if (o4 + (t * r4) + ((t - 1) * t \ 2) <= msf) return 0
  if ((o1 >= bp(5)) && (o3 >= bp(6))) {
    return ..dfs(.cache, .bp, r1, r2, r3, r4+1, no1-bp(5), no2, no3-bp(6), no4, mo1, t-1)
  }
  set msf = 0
  if ((o1 >= bp(3)) && (o2 >= bp(4)) && (r3+1 <= bp(6))) {
    set msf = ..Max(msf, ..dfs(.cache, .bp, r1, r2, r3+1, r4, no1-bp(3), no2-bp(4), no3, no4, mo1, t-1))
  }
  if ((o1 >= bp(1)) && (r1+1 <= mo1)) {
    set msf = ..Max(msf, ..dfs(.cache, .bp, r1+1, r2, r3, r4, no1-bp(1), no2, no3, no4, mo1, t-1))
  }
  if ((o1 >= bp(2) && (r2+1 <= bp(4)))) {
    set msf = ..Max(msf, ..dfs(.cache, .bp, r1, r2+1, r3, r4, no1-bp(2), no2, no3, no4, mo1, t-1))
  }
  set msf = ..Max(msf, ..dfs(.cache, .bp, r1, r2, r3, r4, no1, no2, no3, no4, mo1, t-1))
  set cache(r1, r2, r3, r3, o1, o2, o3, o4, t) = msf
  return msf
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/19.in", .ls)
  set total = 0
  for i=1:1:ls {
    kill cache, bp
    set nums = "", ind = 1
    for j=1:1:$length(ls(i)) {
      set c = $e(ls(i), j)
      if ((($ASCII(c) >= $ASCII(0)) && ($ASCII(c) <= $ASCII(9))) || ((c = " ") && ($e(nums, *) '= " ") )) {
        set $e(nums, ind) = c
        set ind = ind + 1
      }
    }
    set nums = $e(nums, 2, *-1)
    for j=2:1:7 set bp(j-1) = $p(nums, " ", j)
    set mo1 = ..Max(bp(1), ..Max(bp(2), ..Max(bp(3), bp(5))))
    set total = total + (i * ..dfs(.cache, .bp, 1, 0, 0, 0, 0, 0, 0, 0, mo1))
  }
  return total
}

ClassMethod dfs2(ByRef cache, ByRef bp, r1, r2, r3, r4, o1, o2, o3, o4, mo1, t = 24) [ ProcedureBlock = 1 ]
{
  set no1 = o1 + r1, no2 = o2 + r2, no3 = o3 + r3, no4 = o4 + r4
  if (t = 1) return no4
  if ($d(cache(r1, r2, r3, r3, o1, o2, o3, o4, t), targ)) return targ
  if ((o1 >= bp(5)) && (o3 >= bp(6))) {
    return ..dfs2(.cache, .bp, r1, r2, r3, r4+1, no1-bp(5), no2, no3-bp(6), no4, mo1, t-1)
  }
  if ((o1 >= bp(3)) && (o2 >= bp(4)) && (r3+1 <= bp(6))) {
    return ..dfs2(.cache, .bp, r1, r2, r3+1, r4, no1-bp(3), no2-bp(4), no3, no4, mo1, t-1)
  }
  set msf = 0
  if ((o1 >= bp(1)) && (r1+1 <= mo1)) {
    set msf = ..Max(msf, ..dfs2(.cache, .bp, r1+1, r2, r3, r4, no1-bp(1), no2, no3, no4, mo1, t-1))
  }
  if ((o1 >= bp(2) && (r2+1 <= bp(4)))) {
    set msf = ..Max(msf, ..dfs2(.cache, .bp, r1, r2+1, r3, r4, no1-bp(2), no2, no3, no4, mo1, t-1))
  }
  if (o1 < 4) {
    set msf = ..Max(msf, ..dfs2(.cache, .bp, r1, r2, r3, r4, no1, no2, no3, no4, mo1, t-1))
  }
  set cache(r1, r2, r3, r3, o1, o2, o3, o4, t) = msf
  return msf
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/19.in", .ls)
  set total = 1
  for i=1:1:3 {
    kill cache, bp
    set nums = "", ind = 1
    for j=1:1:$length(ls(i)) {
      set c = $e(ls(i), j)
      if ((($ASCII(c) >= $ASCII(0)) && ($ASCII(c) <= $ASCII(9))) || ((c = " ") && ($e(nums, *) '= " ") )) {
        set $e(nums, ind) = c
        set ind = ind + 1
      }
    }
    set nums = $e(nums, 2, *-1)
    for j=2:1:7 set bp(j-1) = $p(nums, " ", j)
    set mo1 = ..Max(bp(1), ..Max(bp(2), ..Max(bp(3), bp(5))))
    set total = total * ..dfs2(.cache, .bp, 1, 0, 0, 0, 0, 0, 0, 0, mo1, 32)
  }
  return total
}

}
