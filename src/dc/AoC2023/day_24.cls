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
  // Only tricky thing here is we have to implement a rational numbers class to make sure we stay in bounds;
  // if we used division in Reals, the floating point inaccuracies for such large bounds would get wrong answer.
  // Iterate over pairs of lines, see if there is an intersection inside the bounds.
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
  // this will take awhile.
  d ..Read("/irisdev/app/inputs/2023/24.in", .ls)
  zw "had to implement a naive equation solver for part 2... takes a few minutes (less than 5)"
  set x = "", y = "", z = "", dx = "", dy = "", dz = ""
  set cdx = "", cdy = "", cdz = ""
  for i=1:1:3 {
    set l = ls(i)
    set p = $p(l, " @ "), v = $p(l, " @ ", 2)
    set x(i - 1) = $p(p, ", ")
    set y(i - 1) = $p(p, ", ", 2)
    set z(i - 1) = $p(p, ", ", 3)
    set cdx(i - 1) = $p(v, ", ")
    set cdy(i - 1) = $p(v, ", ", 2)
    set cdz(i - 1) = $p(v, ", ", 3)
  }

  // Main intution: the velocities of the rock cannot be that large; otherwise would not be able to intersect
  // with every hailstone.
  // That means we can brute force on what the 3 component velocities are (this also turns the quadratic 
  // system of equations to linear).
  // After that, use gaussian elimination to deduce of the resulting system of equations has a working solution
  // for the positions.
  for DX=-400:1:400 {
    for i = 0:1:2 {
      set dx(i) = cdx(i) - DX
    }
    for DY=-200:1:200 {
      for i = 0:1:2 {
        set dy(i) = cdy(i) - DY
      }
      // The times can be solved for only using x and y positions.
      // Move out of the DZ loop to speed up.
      set a = ((dy(0) * (x(0) - x(1))) - (dx(0) * (y(0) - y(1))))
      set b = ((dx(1) * dy(0)) - (dx(0) * dy(1)))
      if (b = 0) {
        continue
      }
      set t(1) = a \ b
      set a = (x(1) - x(2) + (dx(1) * t(1)))
      set b = dx(2)
      if (b = 0) {
        continue
      }
      set t(2) = a \ b
      if (dx(0) = 0) {
        continue
      }
      set t(0) = (x(0) - x(1) - (dx(1) * t(1))) \ (-dx(0))

      for DZ=-400:1:400 {
        for i = 0:1:2 {
          set dz(i) = cdz(i) - DZ
        }

        set ok = 1
        set cx0 = t(0) * dx(0) + x(0)
        set cy0 = t(0) * dy(0) + y(0)
        set cz0 = t(0) * dz(0) + z(0)

        for i=1:1:2 {
          set cx = t(i) * dx(i) + x(i)
          if (cx '= cx0) {
            set ok = 0
            quit
          }
          set cy = t(i) * dy(i) + y(i)
          if (cy '= cy0) {
            set ok = 0
            quit
          }
          set cz = t(i) * dz(i) + z(i)
          if (cz '= cz0) {
            set ok = 0
            quit
          }
        }

        if (ok) {
          return cx0 + cy0 + cz0
        }
      }
    }
  }
  return -1
}

}
