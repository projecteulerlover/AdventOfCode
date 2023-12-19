Class dc.AoC2023.day8 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/8.in", .input)

  set D = input(1)

  set G = ""
  for i=3:1:input {
    set a = $e(input(i), 1, 3)
    set b = $e(input(i), 8, 10)
    set c = $e(input(i), 13, 15)
    set G(a) = b_" "_c
  }

  set s = "AAA"
  set res = 0

  while (s '= "ZZZ") {
    set d = $e(D, (res # $length(D)) + 1)
    set dd = 1
    if (d = "R") {
      set dd = 2
    }
    set s = $p(G(s), " ", dd)
    set res = res + 1
  }

  return res
}

ClassMethod Solve(ByRef G, ByRef D, s) As %Status [ ProcedureBlock = 1 ]
{
  set res = 0
  while ($e(s, 3) '= "Z") {
    set d = $e(D, (res # $length(D)) + 1)
    set dd = 1
    if (d = "R") {
      set dd = 2
    }
    set s = $p(G(s), " ", dd)
    set res = res + 1
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/8.in", .input)

  set D = input(1)

  set G = ""
  set res = 1
  for i=3:1:input {
    set a = $e(input(i), 1, 3)
    set b = $e(input(i), 8, 10)
    set c = $e(input(i), 13, 15)
    set G(a) = b_" "_c
  }

  set s = ""
  for {
    set s = $o(G(s))
    if (s = "") {
      quit
    }
    if ($e(s, 3) = "A") {
      set res = ..LCM(res, ..Solve(.G, .D, s))
    }
  }

  return res
}

}
