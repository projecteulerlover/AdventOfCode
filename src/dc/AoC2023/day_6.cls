Class dc.AoC2023.day6 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/6.in", .input)
  d ..RemoveColon(.input)
  d ..GetInts(.input)
  set res = 1
  for i=1:1:$length(input(1), " ") {
    set t = $p(input(1), " ", i)
    set d = $p(input(2), " ", i)
    set w = 0
    for j = 0:1:t {
      if ((j * (t - j)) > d) {
        set w = w + 1
      }
    }
    set res = res * w
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/6.in", .input)
  d ..RemoveColon(.input)
  d ..GetInts(.input)
  set res = 1
  set t = "", d = ""
  for i=1:1:$length(input(1), " ") {
    set t = t_$p(input(1), " ", i)
    set d = d_$p(input(2), " ", i)
  }
  set t = +t, d = +d

  for j = 0:1:t {
    if ((j * (t - j)) > d) {
      set res = res + 1
    }
  }
  return res
}

}
