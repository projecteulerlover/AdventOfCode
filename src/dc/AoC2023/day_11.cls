Class dc.AoC2023.day11 Extends dc.AoC2023.base
{

ClassMethod Solve(ByRef A, expand) As %Status [ ProcedureBlock = 1 ]
{
  set B = []
  set setA = ""
  for i=0:1:A.%Size() - 1 {
    set setA(A.%Get(i)) = ""
  }
  for i=0:1:A.%Size() - 1 {
    set a = A.%Get(i)
    set res = 0
    for x=1:1:a-1 {
      if ($d(setA(x))) {
        set res = res + 1
      } else {
        set res = res + expand
      }
    }
    d B.%Push(res)
  }
  set sum = 0
  for i=0:1:B.%Size() - 1 {
    set b1 = B.%Get(i)
    for j=i+1:1:B.%Size() - 1 {
      set b2 = B.%Get(j)
      set sum = sum + $zabs(b2 - b1)
    }
  }
  return sum
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/11.in", .ls)

  set R = ls, C = $LENGTH(ls(1))
  set rs = [], cs = []

  for r=1:1:R {
    for c=1:1:C {
      if ($e(ls(r), c) = "#") {
        d rs.%Push(r)
        d cs.%Push(c)
      }
    }
  }
  set rsum = ..Solve(.rs, 2), csum = ..Solve(.cs, 2)

  return rsum + csum
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/11.in", .ls)

  set R = ls, C = $LENGTH(ls(1))
  set rs = [], cs = []

  for r=1:1:R {
    for c=1:1:C {
      if ($e(ls(r), c) = "#") {
        d rs.%Push(r)
        d cs.%Push(c)
      }
    }
  }
  set rsum = ..Solve(.rs, 1000000), csum = ..Solve(.cs, 1000000)

  return rsum + csum
}

}
