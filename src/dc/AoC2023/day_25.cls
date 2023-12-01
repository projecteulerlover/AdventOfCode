Class dc.AoC2023.day25 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/25.in", .ls)
  set r = 0
  for i=1:1:ls {
    set t = 0, n = $LENGTH(ls(i))
    for j=1:1:n {
      set c = $e(ls(i), j)
      if (c = "=") {
        set t = t - (2 * $zpower(5, n-j))
      } elseif (c = "-") {
        set t = t - $zpower(5, n-j)
      } elseif (c = "1") {
        set t = t + $zpower(5, n-j)
      } elseif (c = "2") {
        set t = t + (2 * $zpower(5, n-j))
      }
    }
    set r = r + t
  }
  set i = 1, ans = ""
  while (r > 0) {
    set rem = r # 5
    set c = $e("=-012", (rem+2) # 5 + 1)
    set $e(ans, i) = c
    set i = i + 1, r = r - ((rem+2) # 5) + 2, r = r \ 5
  }
  return $reverse(ans)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/25.in", .ls)
  return "happy holidays!"
}

}
