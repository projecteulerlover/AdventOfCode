Class dc.AoC2022.day11 Extends dc.AoC2022.base
{

ClassMethod BuildMonkeys(ByRef ls, ByRef monkey, ByRef tests) As %Status [ ProcedureBlock = 1 ]
{
  s monkey = ls-1
  for i=1:1:ls {
    set monkey(i-1) = $LISTFROMSTRING($p(ls(i, 2), ": ", 2), ", ")
    set monkey(i-1, "op") = "return "_$p(ls(i, 3), " ", 6, *)
    set $list(tests, i) = $p(ls(i, 4), " ", 6)_" "_$p(ls(i, 5), " ", 10)_" "_$p(ls(i, 6), " ", 10)
  }
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/11.in", .ls, 1)
  d ..BuildMonkeys(.ls, .monkey, .tests)
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
        set op = $replace(monkey(m, "op"), "old", item)
        set x = $XECUTE(op) \ 3
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
  d ..Read("/irisdev/app/inputs/2022/11.in", .ls, 1)
  d ..BuildMonkeys(.ls, .monkey, .tests)
  for m=0:1:monkey {
    set counter(m) = 0
  }
  set mod = 1
  for m=0:1:monkey {
    set mod = mod * $p($list(tests, m+1), " ")
  }
  for t=1:1:10000 {
    for m=0:1:monkey {
      set counter(m) = counter(m) + $LISTLENGTH(monkey(m))
      set ptr = 0
      set test = $list(tests, m+1)
      set a = $p(test, " "), b = $p(test, " ", 2), c = $p(test, " ", 3)
      while $listnext(monkey(m), ptr, item) {
        if ($d(item) = 0) continue
        set op = $replace(monkey(m, "op"), "old", item)
        set x = $XECUTE(op) # mod
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
