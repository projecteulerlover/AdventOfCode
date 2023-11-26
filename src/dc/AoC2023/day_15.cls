Class dc.AoC2022.day15 Extends dc.AoC2022.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/15.in", .ls)
  set Y = 2000000
  set vs = "", bs = ""
  for i=1:1:ls {
    set l = $replace(ls(i), "Sensor at x=", "")
    set l = $replace(l, ", y=", " ")
    set l = $replace(l, ": closest beacon is at x=", " ")
    set x = $p(l, " "), y = $p(l, " ", 2)
    set cx = $p(l, " ", 3), cy = $p(l, " ", 4)
    if (cy = Y) set bs(cx) = ""
    set d = $zabs(x - cx) + $zabs(y - cy)
    set dy = $zabs(Y - y)
    set free = ..Max(d - dy, 0)
    for ix=x-free:1:x+free set vs(ix) = ""
  }
  set ptr = "", res = 0
  for {
    set ptr = $o(vs(ptr))
    if (ptr = "") quit
    if ('$d(bs(ptr))) set res = res + 1
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  zw "This will take awhile"
  d ..Read("/irisdev/app/inputs/2023/15.in", .ls)
  set Y = 2000000, bs = ""
  for i=1:1:ls {
      set l = $replace(ls(i), "Sensor at x=", "")
      set l = $replace(l, ", y=", " ")
      set l = $replace(l, ": closest beacon is at x=", " ")
      set ls(i) = l
      set x = $p(l, " "), y = $p(l, " ", 2)
      set cx = $p(l, " ", 3), cy = $p(l, " ", 4)
      set bs(x, y) = "", bs(cx, cy) = ""
  }
  for yy=2*Y:-1:0  {
    kill ints
    set ints = ""
    for i=1:1:ls {
      set l = ls(i)
      set x = $p(l, " "), y = $p(l, " ", 2)
      set cx = $p(l, " ", 3), cy = $p(l, " ", 4)
      set d = $zabs(x - cx) + $zabs(y - cy)
      set dy = $zabs(yy - y)
      if (d - dy < 0) continue
      set free = d - dy
      set l = ..Max(0, x-free), r = ..Min(2*Y, x+free)
      if ($d(ints(l))) {
        set ints(l) = ..Max(r, ints(l))
      } else {
        set ints(l) = r
      }
    }
    set ptr = $order(ints(""), 1, msf)
    for {
      set ptr = $order(ints(ptr), 1, x)
      if (ptr = "") quit
      if ((msf + 2 = ptr) && ('$d(bs(yy, msf+1)))) {
        return (msf + 1) * 2 * Y + (yy)
      }
      set msf = ..Max(msf, x)
      if (2*Y = msf) continue
    }
  }
  return -1
}

}
