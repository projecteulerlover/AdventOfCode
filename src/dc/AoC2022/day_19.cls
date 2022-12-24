Class dc.AoC2022.day19 Extends dc.AoC2022.base
{

ClassMethod dfs(ByRef cache, ByRef bp, rs, os, mo1, t = 24) [ ProcedureBlock = 1 ]
{
  set r1 = $p(rs, " "), r2 = $p(rs, " ", 2), r3 = $p(rs, " ", 3), r4 = $p(rs, " ", 4)
  set o1 = $p(os, " "), o2 = $p(os, " ", 2), o3 = $p(os, " ", 3), o4 = $p(os, " ", 4)
  set no1 = o1 + r1, no2 = o2 + r2, no3 = o3 + r3, no4 = o4 + r4
  if (t = 1) return no4
  if ($d(cache(rs, os, t), targ)) return targ
  set msf = 0
  if ((o1 >= bp(5)) && (o3 >= bp(6))) {
    return ..dfs(.cache, .bp, r1_" "_r2_" "_r3_" "_(r4+1), (no1-bp(5))_" "_no2_" "_(no3-bp(6))_" "_no4, mo1, t-1)
  }
  if ((o1 >= bp(3)) && (o2 >= bp(4)) && (r3+1 <= bp(6))) {
    set msf = ..Max(msf, ..dfs(.cache, .bp, r1_" "_r2_" "_(r3+1)_" "_r4, (no1-bp(3))_" "_(no2-bp(4))_" "_no3_" "_no4, mo1, t-1))
  }
  if ((o1 >= bp(1)) && (r1+1 <= mo1)) {
    set msf = ..Max(msf, ..dfs(.cache, .bp, (r1+1)_" "_r2_" "_r3_" "_r4, (no1-bp(1))_" "_no2_" "_no3_" "_no4, mo1, t-1))
  }
  if ((o1 >= bp(2) && (r2+1 <= bp(4)))) {
    set msf = ..Max(msf, ..dfs(.cache, .bp, r1_" "_(r2+1)_" "_r3_" "_r4, (no1-bp(2))_" "_no2_" "_no3_" "_no4, mo1, t-1))
  }
  set msf = ..Max(msf, ..dfs(.cache, .bp, r1_" "_r2_" "_r3_" "_r4, no1_" "_no2_" "_no3_" "_o4, mo1, t-1))
  set cache(rs, os, t) = msf
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
    set total = total + (i * ..dfs(.cache, .bp, "1 0 0 0", "0 0 0 0", mo1))
  }
  return total
}

ClassMethod dfs2(ByRef cache, ByRef bp, rs, os, mo1, t = 24) [ ProcedureBlock = 1 ]
{
  set r1 = $p(rs, " "), r2 = $p(rs, " ", 2), r3 = $p(rs, " ", 3), r4 = $p(rs, " ", 4)
  set o1 = $p(os, " "), o2 = $p(os, " ", 2), o3 = $p(os, " ", 3), o4 = $p(os, " ", 4)
  set no1 = o1 + r1, no2 = o2 + r2, no3 = o3 + r3, no4 = o4 + r4
  if (t = 1) return no4
  if ($d(cache(rs, os, t), targ)) return targ
  if ((o1 >= bp(5)) && (o3 >= bp(6))) {
    return ..dfs2(.cache, .bp, r1_" "_r2_" "_r3_" "_(r4+1), (no1-bp(5))_" "_no2_" "_(no3-bp(6))_" "_no4, mo1, t-1)
  }
    if ((o1 >= bp(3)) && (o2 >= bp(4)) && (r3+1 <= bp(6))) {
    return ..dfs2(.cache, .bp, r1_" "_r2_" "_(r3+1)_" "_r4, (no1-bp(3))_" "_(no2-bp(4))_" "_no3_" "_no4, mo1, t-1)
  }
  set msf = 0
  if ((o1 >= bp(1)) && (r1+1 <= mo1)) {
    set msf = ..Max(msf, ..dfs2(.cache, .bp, (r1+1)_" "_r2_" "_r3_" "_r4, (no1-bp(1))_" "_no2_" "_no3_" "_no4, mo1, t-1))
  }
  if ((o1 >= bp(2) && (r2+1 <= bp(4)))) {
    set msf = ..Max(msf, ..dfs2(.cache, .bp, r1_" "_(r2+1)_" "_r3_" "_r4, (no1-bp(2))_" "_no2_" "_no3_" "_no4, mo1, t-1))
  }
  if (o1 < 4) {
    set msf = ..Max(msf, ..dfs2(.cache, .bp, rs, no1_" "_no2_" "_no3_" "_no4, mo1, t-1))
  }
  set cache(rs, os, t) = msf
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
    set total = total * ..dfs2(.cache, .bp, "1 0 0 0", "0 0 0 0", mo1, 32)
  }
  return total
}

}
