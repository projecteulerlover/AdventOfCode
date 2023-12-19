Class dc.AoC2023.day15 Extends dc.AoC2023.base
{

ClassMethod Hash(token) As %Status [ ProcedureBlock = 1 ]
{
  set hash = 0
  for j=1:1:$length(token) {
    set x = $e(token, j)
    set hash = hash + $ascii(x)
    set hash = 17 * hash
    set hash = hash # 256
  }
  return hash
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/15.in", .ls)

  set l = ls(1)
  set res = 0
  for i=1:1:$length(l, ",") {
    set hash = 0
    set token = $p(l, ",", i)
    set res = res + ..Hash(token)
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/15.in", .ls)

  set l = ls(1)
  set res = 0

  for i=1:1:$length(l, ",") {
    set token = $p(l, ",", i)
    set tl = $length(token, "=")
    if (tl = 2) {
      set var = $p(token, "="), val = $p(token, "=", 2)
      if ('$d(slots(var))) {
        set slots(var) = i
      }
      set hm(..Hash(var), slots(var), var) = val
    } else {
      set var = $e(token, 1, *-1)
      if ($d(slots(var))) {
        kill hm(..Hash(var), slots(var), var)
        kill slots(var)
      }
    }
  }

  set box = ""
  for {
    set box = $o(hm(box))
    if (box = "") {
      quit
    }

    set slot = ""
    set s = 0
    for {
      set slot = $o(hm(box, slot))
      if (slot = "") {
        quit
      }
      set s = s + 1

      set var = ""
      for {
        set var = $o(hm(box, slot, var), 1, f)
        if (var = "") {
          quit
        }
        set res = res + ((box + 1) * s * f)
      }
    }
  }
  return res
}

}
