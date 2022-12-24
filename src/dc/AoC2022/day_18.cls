Class dc.AoC2022.day18 Extends dc.AoC2022.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/18.in", .ls)
  set space = 0
  for i=1:1:ls set space(ls(i)) = ""
  set coord = "", total = 0
  for {
    set coord = $order(space(coord))
    if (coord = "") quit
    set total = total + 6
    for i=1:1:3 {
      for d=-1:2:1 {
        set cc = coord
        set $p(cc, ",", i) = $p(cc, ",", i) + d
        if ($d(space(cc))) set total = total - 1
      }
    }
  }
  return total
}

ClassMethod ok(cMin, cc, cMax) [ ProcedureBlock = 1 ]
{
  for i=1:1:3 {
    set s = $p(cMin, ",", i), m = $p(cc, ",", i), l = $p(cMax, ",", i)
    if ((s > m) || (m > l)) return 0
  }
  return 1
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/18.in", .ls)
  set space = 0, cMin = ls(1), cMax = ls(1), total = 0
  for i=1:1:ls {
    set space(ls(i)) = ""
    for j=1:1:3 {
      set $p(cMin, ",", j) = ..Min($p(cMin, ",", j), $p(ls(i), ",", j)-1)
      set $p(cMax, ",", j) = ..Max($p(cMax, ",", j), $p(ls(i), ",", j)+1) 
    }
  }
  set st = [], vs = ""
  do st.%Push(cMin)
  set vs(cMin) = ""
  while (st.%Size() > 0) {
    zw p
    for i=1:1:3 {
      for d=-1:2:1 {
        set cc = p
        set $p(cc, ",", i) = $p(cc, ",", i) + d
        if ($d(space(cc))) {
          set total = total + 1
        } elseif ('$d(vs(cc)) && ..ok(cMin, cc, cMax)) {
          do st.%Push(cc)
          set vs(cc) = ""
        }
      }
    }
  }
  return total
}

}
