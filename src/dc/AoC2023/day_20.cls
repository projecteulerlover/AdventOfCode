Class dc.AoC2023.day20 Extends dc.AoC2023.base
{

ClassMethod Remove(ByRef vector, index) [ ProcedureBlock = 1 ]
{
  set vector = vector-1
  for i=index:1:vector-1 {
    set vector(i) = vector(i+1)
  }
  kill vector(vector)
}

ClassMethod Insert(ByRef vector, index, x) [ ProcedureBlock = 1 ]
{
  set vector = vector + 1
  if (vector-1 = index) {
    set vector(index) = x
    return
  }
  for i=vector-1:-1:index+1 {
    set vector(i) = vector(i-1)
  }
  set vector(index) = x
}

ClassMethod Find(ByRef vector, x) [ ProcedureBlock = 1 ]
{
  for i=0:1:vector-1 {
    if (vector(i) = x) return i
  }
  return -1
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/20.in", .ls)
  set n = ls
  set nums = n, indices = n
  for i=1:1:ls {
    set nums(i-1) = +ls(i)
    set indices(i-1) = i-1
  }
  for i=0:1:n-1 {
    set j = ..Find(.indices, i)
    do ..Remove(.indices, j)
    set j = (j + nums(i)) # (n - 1)
    do ..Insert(.indices, j, i)
  }
  set ans = 0
  set ind = ..Find(.indices, ..Find(.nums, 0))
  for i=1000:1000:3000 {
    set ans = ans + nums(indices((ind+i) # n))
  }
  return ans
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/20.in", .ls)
  set n = ls, hash = 811589153
  set nums = n, indices = n
  for i=1:1:ls {
    set nums(i-1) = hash * (+ls(i))
    set indices(i-1) = i-1
  }
  for z=1:1:10 {
    for i=0:1:n-1 {
      set j = ..Find(.indices, i)
      do ..Remove(.indices, j)
      set j = (j + nums(i)) # (n - 1)
      do ..Insert(.indices, j, i)
    }
  }
  set ans = 0
  set ind = ..Find(.indices, ..Find(.nums, 0))
  for i=1000:1000:3000 {
    set ans = ans + nums(indices((ind+i) # n))
  }
  return ans
}

}
