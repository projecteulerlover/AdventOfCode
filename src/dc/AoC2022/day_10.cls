Class dc.AoC2022.day10 Extends dc.AoC2022.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/10.in", .input)
  set x = 1, t = 0, j = 0, cs = 0
  for i=20:40:220 {
    set cs(i) = ""
  }
  for i=1:1:input {
    set j = j+1
    if ($d(cs(j))) set t = j * x + t
    if ($length(input(i), " ") = 2) {
      set j = j+1
      if ($d(cs(j)))  set t = j * x + t
      set x = x + $p(input(i), " ", 2)
    }
  }
  return t
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/10.in", .input)
  set x = 1, j = 0, cs = 0
  set crt = ""
  for i=1:1:6 {
    set crt(i) = ""
  }
  for i=1:1:input {
    set draw = j#40, row = (j-1)\40 + 1
    if ((x-1 <= draw) && (draw <= (x+1))) set $e(crt(row), draw+1) = "#"
    set j = j+1
    if ($length(input(i), " ") = 2) {
      set draw = j#40, row = (j-1)\40 + 1
      if ((x-1 <= draw) && (draw <= (x+1))) set $e(crt(row), draw+1) = "#"
      set x = x + $p(input(i), " ", 2)
      set j = j+1
    }
  }
  for r=1:1:6 {
    w crt(r), !
  }
  return "RFZEKBFA"
}

}
