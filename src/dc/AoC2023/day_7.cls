Class dc.AoC2022.day7 Extends dc.AoC2022.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/7.in", .input)
  set res = 0, path = $lb()
  for i=1:1:input {
    set l = input(i)
    if ($p(l, " ", 1) = "$") {
      if ($p(l, " ", 2) = "cd") {
        if ($p(l, " ", 3) = "..") {
          set path = $list(path, 1, *-1)
        } else {
          set $list(path, *+1) = $p(l, " ", 3)
        }
      }
    } elseif ($p(l, " ", 1) '= "dir") {
      for j=1:1:$LISTLENGTH(path) {
        set mem($list(path, 1, j)) = $g(mem($list(path, 1, j)), 0) + $p(l, " ", 1)
      }
    }
  }
  set res = 0, x = ""
  for {
    set x = $o(mem(x), 1, t)
    if (x = "") quit
    if (t <= 100000) set res = res + t
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/7.in", .input)
  set res = 0, path = $lb()
  for i=1:1:input {
    set l = input(i)
    if ($p(l, " ", 1) = "$") {
      if ($p(l, " ", 2) = "cd") {
        if ($p(l, " ", 3) = "..") {
          set path = $list(path, 1, *-1)
        } else {
          set $list(path, *+1) = $p(l, " ", 3)
        }
      }
    } elseif ($p(l, " ", 1) '= "dir") {
      for j=1:1:$LISTLENGTH(path) {
        set mem($list(path, 1, j)) = $g(mem($list(path, 1, j)), 0) + $p(l, " ", 1)
      }
    }
  }
  set res = 999999999999, x = "", v = mem($lb(,"/")) - 40000000
  for {
    set x = $o(mem(x), 1, t)
    if (x = "") quit
    if (t >= v) set res = ..Min(res, t)
  }
  return res
}

}
