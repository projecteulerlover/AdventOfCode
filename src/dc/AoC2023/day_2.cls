Class dc.AoC2023.day2 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/2.in", .input)
  set dp("A X") = 4
  set dp("A Y") = 8
  set dp("A Z") = 3
  set dp("B X") = 1
  set dp("B Y") = 5
  set dp("B Z") = 9
  set dp("C X") = 7
  set dp("C Y") = 2
  set dp("C Z") = 6
  set res = 0
  for i=1:1:input {
    set res = res + dp(input(i))
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/2.in", .input)
  set dp("A X") = 3
  set dp("A Y") = 4
  set dp("A Z") = 8
  set dp("B X") = 1
  set dp("B Y") = 5
  set dp("B Z") = 9
  set dp("C X") = 2
  set dp("C Y") = 6
  set dp("C Z") = 7
  set res = 0
  for i=1:1:input {
    set res = res + dp(input(i))
  }
  return res
}

}
