Class dc.AoC2023.day5 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/5.in", .input, 1)
  set n = $extract(input(1, input(1)), *-1)
  set stacks = n
  for i=1:1:n {
    set stacks(i) = ""
  }
  for i=1:1:input(1)-1 {
    for j=1:1:n {
      set c = $extract(input(1, i), 4*j - 2)
      set stacks(j) = stacks(j)_($case(c, " ":"", : c))
    }
  }
  for i=1:1:n {
    set stacks(i) = ..Reverse(stacks(i))
  }
  for i=1:1:input(2) {
    set c = $p(input(2, i), " ", 2)-1, f = $p(input(2, i), " ", 4), t = $p(input(2, i), " ", 6)
    set stacks(t) = stacks(t)_..Reverse($e(stacks(f), *-c, *))
    set $e(stacks(f), *-c, *) = ""
  }
  set res = ""
  for i=1:1:n {
    set res = res_$e(stacks(i), *)
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/5.in", .input, 1)
  set n = $extract(input(1, input(1)), *-1)
  set stacks = n
  for i=1:1:n {
    set stacks(i) = ""
  }
  for i=1:1:input(1)-1 {
    for j=1:1:n {
      set c = $extract(input(1, i), 4*j - 2)
      set stacks(j) = stacks(j)_($case(c, " ":"", : c))
    }
  }
  for i=1:1:n {
    set stacks(i) = ..Reverse(stacks(i))
  }
  for i=1:1:input(2) {
    set c = $p(input(2, i), " ", 2)-1, f = $p(input(2, i), " ", 4), t = $p(input(2, i), " ", 6)
    set stacks(t) = stacks(t)_$e(stacks(f), *-c, *)
    set $e(stacks(f), *-c, *) = ""
  }
  set res = ""
  for i=1:1:n {
    set res = res_$e(stacks(i), *)
  }
  return res
}

}
