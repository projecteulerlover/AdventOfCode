Class dc.AoC2023.day9 Extends dc.AoC2023.base
{

ClassMethod Solve(l) As %Integer [ ProcedureBlock = 1 ]
{
  set nonzero = 0
  set N = $length(l, " ")
  for i=1:1:N {
    if ($p(l, " ", i) '= 0) {
      set nonzero = 1
      quit
    }
  }
  if (nonzero = 0) {
    return 0
  }
  set cur = ""
  for i=1:1:N - 1 {
    if ($length(cur)) {
      set cur = cur_" "_($p(l, " ", i + 1) - $p(l, " ", i))
    } else {
      set cur = $p(l, " ", i + 1) - $p(l, " ", i)
    }
  }
  return $p(l, " ", N)_" "_..Solve(cur)
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/9.in", .input)
  set res = 0
  for i=1:1:input {
    set vs = ..Solve(input(i))
  
    for j=1:1:$length(vs, " ") {
      set res = res + $p(vs, " ", j)
    }
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/9.in", .input)
  set res = 0
  for i=1:1:input {
    set rev = ..ReverseList(input(i))
    set vs = ..Solve(rev)
  
    for j=1:1:$length(vs, " ") {
      set res = res + $p(vs, " ", j)
    }
  }
  return res
}

}
