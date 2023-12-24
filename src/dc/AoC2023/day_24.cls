Class dc.AoC2023.day24 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/24.in", .ls)
  set hs = ""
  for i=1:1:ls {
    set l = ls(i)
    set p = $p(l, " @ "), v = $p(l, " @ ", 2)
    set hs(i, "x") = $p(p, ", ")
    set hs(i, "y") = $p(p, ", ", 2)
    set hs(i, "z") = $p(p, ", ", 3)
    set hs(i, "dx") = $p(v, ", ")
    set hs(i, "dy") = $p(v, ", ", 2)
    set hs(i, "dz") = $p(v, ", ", 3)
  }

  set res = 0
  set MN = 200000000000000, MX = 400000000000000
  for i=1:1:ls {
    set x0 = hs(i, "x"), y0 = hs(i, "y"), z0 = hs(i, "z")
    set dx0 = hs(i, "dx"), dy0 = hs(i, "dy"), dz0 = hs(i, "dz")
    for j=i+1:1:ls {
      set x1 = hs(j, "x"), y1 = hs(j, "y"), z1 = hs(j, "z")
      set dx1 = hs(j, "dx"), dy1 = hs(j, "dy"), dz1 = hs(j, "dz")
    
      if ((dy0 '= 0) && (((dx1 * dy0) - (dy1 * dx0)) '= 0)) {
        set t1num = (dy0 * x0) - (dx0 * y0) - (dy0 * x1) + (dx0 * y1)
        set t1den = (dx1 * dy0) - (dy1 * dx0)
        set g = ..GCD(t1num, t1den)
        set t1num = t1num / g, t1den = t1den / g
        
        set t0num = (t1den * (x1 - x0)) + (t1num * dx1), t0den = dx0 * t1den
        set t0 = t0num / t0den, t1 = t1num / t1den
        if ((t0 >= 0) && (t1 >= 0) && (MN <= (x1 + (t1 * dx1))) && ((x1 + (t1 * dx1)) <= MX) && (MN <= (y1 + (t1 * dy1))) && ((y1 + (t1 * dy1)) <= MX)) {
          set res = res + 1 
        }
      }
    }
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/24.in", .ls)
}

}
