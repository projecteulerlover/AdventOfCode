Class dc.AoC2022.day9 Extends dc.AoC2022.base
{

ClassMethod Helper(sl) As %Integer [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/9.in", .input)
  set mp("R") = 1, mp("D") = 2, mp("L") = 3, mp("U") = 4
  set dir(1) = 1, dir(2) = 0, dir(3) = -1, dir(4) = 0, dir(5) = 1
  set res = 0
  set seen = 1
  set seen("0^0") = ""
  for s=1:1:sl {
    set snake(s, "r") = 0, snake(s, "c") = 0
  }
  
  for i=1:1:input {
    set l = input(i)
    set d = mp($p(l, " ")), x = $p(l, " ", 2)
    set dr = dir(d), dc = dir(d+1)
    for z=1:1:x {
      set snake(1, "r") = snake(1, "r") + dr
      set snake(1, "c") = snake(1, "c") + dc
      for s=2:1:sl {
        set rx = snake(s-1, "r")-snake(s, "r") 
        set cx = snake(s-1, "c")-snake(s, "c")
        if (($zabs(rx) > 1) || ($zabs(cx) > 1)) {
          if ($zabs(rx) > 0) set snake(s, "r") = snake(s, "r") + (rx/$zabs(rx))
          if ($zabs(cx) > 0) set snake(s, "c") = snake(s, "c") + (cx/$zabs(cx))
        }
      }
      if ($d(seen(snake(sl, "r")_"^"_snake(sl, "c"))) = 0) {
        set seen(snake(sl, "r")_"^"_snake(sl, "c")) = i
        set seen = seen + 1
      }
    }
  }
  return seen
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  return ..Helper(2)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  return ..Helper(10)
}

}
