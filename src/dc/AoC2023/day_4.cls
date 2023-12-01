Class dc.AoC2023.day4 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/4.in", .input)
  set res = 0
  for i=1:1:input {
    set l = input(i)
    set a = $p(l, ","), b = $p(l, ",", 2)
    set s1 = $p(a, "-"), e1 = $p(a, "-", 2), s2 = $p(b, "-"), e2 = $p(b, "-", 2)
    if (((s1 <= s2) && (e2 <= e1)) || ((s2 <= s1) && (e1 <= e2))) {
      set res = res + 1
    }
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/4.in", .input)
  set res = 0
  for i=1:1:input {
    set l = input(i)
    set a = $p(l, ","), b = $p(l, ",", 2)
    set s1 = $p(a, "-"), e1 = $p(a, "-", 2), s2 = $p(b, "-"), e2 = $p(b, "-", 2)
    if ((..Max(s1, s2) <= ..Min(e1, e2))) {
      set res = res + 1
    }
  }
  return res
}

}
