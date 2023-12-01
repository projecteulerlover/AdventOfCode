Class dc.AoC2023.day3 Extends dc.AoC2023.base
{

ClassMethod Helper(c) As %Integer [ ProcedureBlock = 1 ]
{
  set x = $ascii(c)
  if (($ascii("a") <= x) && (x <= $ascii("z"))) {
    return x - $ascii("a") + 1
  }
  return x - $ascii("A") + 27
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/3.in", .input)
  set res = 0
  for i=1:1:input {
    set n = $length(input(i))
    set m = n/2
    set a = $extract(input(i), 1, n/2)
    set b = $extract(input(i), n/2 + 1, n)
    kill aSet
    for j=1:1:m {
      set aSet($extract(a, j)) = ""
    }
    for j=1:1:m {
      if ($data(aSet($extract(b, j))) = 1) {
        set res = res + ..Helper($extract(b, j))
        quit
      }
    }
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/3.in", .input)
  set res = 0
  for i=1:3:input {
    set a = input(i), b = input(i+1), c = input(i+2)
    kill aSet, bSet
    for j=1:1:$length(a) {
      set aSet($extract(a, j)) = ""
    }
    for j=1:1:$length(b) {
      if ($data(aSet($extract(b, j))) = 1) {
        set bSet($extract(b, j)) = ""
      }
    }
    for j=1:1:$length(c) {
      if ($data(bSet($extract(c, j))) = 1) {
        set res = res + ..Helper($extract(c, j))
        quit
      }
    }
  }
  return res
}

}
