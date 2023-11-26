Class dc.AoC2022.day13 Extends dc.AoC2022.base
{

ClassMethod Helper(ByRef a, ByRef b) As %Boolean [ ProcedureBlock = 1 ]
{
  set m = $listlength(a), n = $listlength(b)
  if (m && ('$listdata(a, 1))) set m = m - 1
  if (n && ('$listdata(b, 1))) set n = n - 1
  for i=1:1:..Min(m, n) {
    set x = $list(a, i), y = $list(b, i)
    if (('$LISTVALID(x)) && ('$LISTVALID((y)))) {
      set d = x - y
    } elseif (($LISTVALID(x)) && ('$LISTVALID((y)))) {
      set d = ..Helper(.x, $lb(y))
    } elseif (('$LISTVALID(x)) && ($LISTVALID((y)))) {
      set d = ..Helper($lb(x), .y)
    } else {
      set d = ..Helper(.x, .y)
    }
    if (d '= 0) return d
  }
  return m - n
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/13.in", .ls, 1)
  set res = 0
  for i=1:1:150 {
    set a = $replace($replace(ls(i, 1), "[", "$lb("), "]", ")")
    set cmd = "(x) s x="_a_" QUIT 0"
    s null = $XECUTE(cmd, .a)
    if (null) return -1
    set b = $replace($replace(ls(i, 2), "[", "$lb("), "]", ")")
    set cmd = "(x) s x="_b_" QUIT 0"
    s null = $XECUTE(cmd, .b)
    if (null) return -1
    if (..Helper(.a, .b) < 0) set res = res + i
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/13.in", .ls, 1)
  set two = $lb($lb(2)), six = $lb($lb(6))
  set counter2 = 0, counter6 = 0
  if (..Helper(.two, .six) < 0) {
    set counter6 = 1
  } else {
    set counter6 = 1
  }
  for i=1:1:150 {
    set a = $replace($replace(ls(i, 1), "[", "$lb("), "]", ")")
    set cmd = "(x) s x="_a_" QUIT 0"
    s null = $XECUTE(cmd, .a)
    if (null) return -1
    set b = $replace($replace(ls(i, 2), "[", "$lb("), "]", ")")
    set cmd = "(x) s x="_b_" QUIT 0"
    s null = $XECUTE(cmd, .b)
    if (null) return -1
    if (..Helper(.a, .two) < 0) set counter2 = counter2 + 1
    if (..Helper(.a, .six) < 0) set counter6 = counter6 + 1
    if (..Helper(.b, .two) < 0) set counter2 = counter2 + 1
    if (..Helper(.b, .six) < 0) set counter6 = counter6 + 1
  }
  return (1+counter2) * (1+counter6)
}

}
