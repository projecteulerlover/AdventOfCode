Class dc.AoC2023.day18 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/18.in", .ls)
  set res = 0

  set corners = 1
  set corners(1) = "0 0"
  set r = 0, c = 0

  set D("R") = "0 1", D("U") = "-1 0", D("D") = "1, 0", D("L") = "0 -1"
  set b = -1
  for i=1:1:ls {
    set l = ls(i)
    set d = $p(l, " "), x = $p(l, " ", 2), hex = $p(l, " ", 3)
    set dr = $p(D(d), " "), dc = $p(D(d), " ", 2)

    set r = dr * x + r, c = dc * x + c
    set corners = corners + 1
    set corners(corners) = r_" "_c
    set b = b + x
  }

  return ..Shoelace(.corners) - (b \ 2) + 1 + b
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/18.in", .ls)
  set res = 0

  set corners = 1
  set corners(1) = "0 0"
  set r = 0, c = 0

  set D("R") = "0 1", D("U") = "-1 0", D("D") = "1, 0", D("L") = "0 -1"
  set M(0) = "R", M(1) = "D", M(2) = "L", M(3) = "U"
  set b = -1
  for i=1:1:ls {
    set l = ls(i)
    set hex = $p(l, " ", 3)
    set x = $System.Util.HexToDecimal($e(hex, 3, 7))
    set d = M($e(hex, 8))
    set dr = $p(D(d), " "), dc = $p(D(d), " ", 2)

    set r = dr * x + r, c = dc * x + c
    set corners = corners + 1
    set corners(corners) = r_" "_c
    set b = b + x
  }

  return ..Shoelace(.corners) - (b \ 2) + 1 + b
}

}
