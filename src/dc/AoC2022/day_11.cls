Class dc.AoC2022.day11 Extends dc.AoC2022.base
{

ClassMethod ops(i, old) As %Integer [ ProcedureBlock = 1 ]
{
  if (i = 0) {
    return old * 19
  }
  if (i = 1) {
    return old + 1
  }
  if (i = 2) {
    return old + 8
  }
  if (i = 3) {
    return old * old
  }
  if (i = 4) {
    return old + 6
  }
  if (i = 5) {
    return old * 17
  }
  if (i = 6) {
    return old + 5
  }
  #; if (i = 7)
  return old + 3
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  set monkey = 7
  set monkey(0) = $lb(59, 74, 65, 86)
  set monkey(1) = $lb(62, 84, 72, 91, 68, 78, 51)
  set monkey(2) = $lb(78, 84, 96)
  set monkey(3) = $lb(97, 86)
  set monkey(4) = $lb(50)
  set monkey(5) = $lb(73, 65, 69, 65, 51)
  set monkey(6) = $lb(69, 82, 97, 93, 82, 84, 58, 63)
  set monkey(7) = $lb(81, 78, 82, 76, 79, 80)
  set tests = $lb("7 6 2", "2 2 0", "19 6 5", "3 1 0", "13 3 1", "11 4 7", "5 5 7", "17 3 4")
  for m=0:1:monkey {
    set counter(m) = 0
  }
  for t=1:1:20 {
    for m=0:1:monkey {
      set counter(m) = counter(m) + $LISTLENGTH(monkey(m))
      set ptr = 0
      set test = $list(tests, m+1)
      set a = $p(test, " "), b = $p(test, " ", 2), c = $p(test, " ", 3)
      while $listnext(monkey(m), ptr, item) {
        set x = ..ops(m, item) \ 3
        set y = b
        if (x # a > 0) set y = c
        set $list(monkey(y), *+1) = x
      }
      set monkey(m) = ""
    }
  }
  for m=0:1:monkey {
    set scounter(counter(m)) = ""
  }
  set ptr = "", res = 1
  for i=1:1:2 {
    set ptr = $order(scounter(ptr), -1)
    set res = res * ptr
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  set monkey = 7
  set monkey(0) = $lb(59, 74, 65, 86)
  set monkey(1) = $lb(62, 84, 72, 91, 68, 78, 51)
  set monkey(2) = $lb(78, 84, 96)
  set monkey(3) = $lb(97, 86)
  set monkey(4) = $lb(50)
  set monkey(5) = $lb(73, 65, 69, 65, 51)
  set monkey(6) = $lb(69, 82, 97, 93, 82, 84, 58, 63)
  set monkey(7) = $lb(81, 78, 82, 76, 79, 80)
  set tests = $lb("7 6 2", "2 2 0", "19 6 5", "3 1 0", "13 3 1", "11 4 7", "5 5 7", "17 3 4")
  set mod = 1
  for m=0:1:monkey {
    set mod = mod * $p($list(tests, m+1), " ")
  }
  for m=0:1:monkey {
    set counter(m) = 0
  }
  for t=1:1:10000 {
    for m=0:1:monkey {
      set counter(m) = counter(m) + $LISTLENGTH(monkey(m))
      set ptr = 0
      set test = $list(tests, m+1)
      set a = $p(test, " "), b = $p(test, " ", 2), c = $p(test, " ", 3)
      while $listnext(monkey(m), ptr, item) {
        if ($d(item) = 0) continue
        set x = ..ops(m, item) # mod
        set y = b
        if (x # a > 0) set y = c
        set $list(monkey(y), *+1) = x
      }
      set monkey(m) = ""
    }
  }
  for m=0:1:monkey {
    set scounter(counter(m)) = ""
  }
  set ptr = "", res = 1
  for i=1:1:2 {
    set ptr = $order(scounter(ptr), -1)
    set res = res * ptr
  }
  return res
}

}
