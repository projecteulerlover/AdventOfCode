Class dc.AoC2023.day2 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/2.in", .input)

  d ..RemoveColon(.input)

  set res = 0
  for i=1:1:input {
    set cs("red") = 0, cs("green") = 0, cs("blue") = 0
    set line = $TRANSLATE(input(i), ",;", "")
    for j=1:2:$LENGTH(line, " ") {
      set color = $piece(line, " ", j + 1)
      set cs(color) = ..Max(cs(color), +$piece(line, " ", j))
    }
    if ((cs("red") <= 12) && (cs("green") <= 13) && (cs("blue") <= 14)) {
      set res = res + i
    }
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/2.in", .input)

  d ..RemoveColon(.input)

  set res = 0
  for i=1:1:input {
    set cs("red") = 0, cs("green") = 0, cs("blue") = 0
    set line = $TRANSLATE(input(i), ",;", "")
    for j=1:2:$LENGTH(line, " ") {
      set color = $piece(line, " ", j + 1)
      set cs(color) = ..Max(cs(color), +$piece(line, " ", j))
    }
    set res = res + (cs("red") * cs("green") * cs("blue"))
  }
  return res
}

}
