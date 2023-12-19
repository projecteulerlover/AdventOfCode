Class dc.AoC2023.day7 Extends dc.AoC2023.base
{

ClassMethod GetKey(hand, part2 = 0) As %String [ ProcedureBlock = 1 ]
{
  set h = ""
  for i=1:1:$length(hand) {
    set c = $e(hand, i)
    set h(c) = $g(h(c), 0) + 1
  }
  set res = 0

  set all = "LMNOPQRSTUVWX"
  if (part2) {
    set all = "ALMNOPQRSTVWX"
  }
  set ordered = ""
  for j=1:1:5 {
    set d = $e(hand, j)
    set res = res + h(d)
    for i=13:-1:1 {
      set c = $e(all, i)
      if (d = c) {
        set ordered = ordered_c
      }
    }
  }

  return res_"^"_ordered
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/7.in", .input)
  set res = 0

  set sorted = ""
  for i=1:1:input {
    set h = $p(input(i), " ", 1), c = $p(input(i), " ", 2)
    set h = $translate(h, "23456789TJQKA", "LMNOPQRSTUVWX")
    set key = ..GetKey(h)
    set sorted($p(key, "^"), $p(key, "^", 2), i) = c
  }

  set x = "", rank = 1
  for {
    set x = $o(sorted(x))
    if (x = "") {
      quit
    }
    set y = ""
    for {
      set y = $o(sorted(x, y))
      if (y = "") {
        quit
      }
      set z = ""
      for {
        set z = $o(sorted(x, y, z), 1, c)
        if (z = "") {
          quit
        }
        set res = res + (rank * c)
        set rank = rank + 1
      }
    }
  }

  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/7.in", .input)
  set res = 0

  set sorted = ""
  for i=1:1:input {
    set h = $p(input(i), " ", 1), c = $p(input(i), " ", 2)
    set REPLACEMENT = "LMNOPQRSTUVWX"
    set h = $translate(h, "23456789TJQKA", REPLACEMENT)
    set h = $translate(h, "U", "A")
    set J = "A"
    
    set BEST = ..GetKey(h, 1)
    
    set BEST1 = $p(BEST, "^", 1)
    set BEST2 = $p(BEST, "^", 2)

    set jacks = 0
    for j=1:1:$length(h) {
      set card = $e(h, j)
      if (card = J) {
        set jacks = 1
        continue
      }
    }

    if ('jacks) {
      set sorted(BEST1, BEST2, i) = c
      continue
    }

    for k=1:1:13 {
      set r = $e(REPLACEMENT, k)
      if (r = J) {
        continue
      }
      set nkey = ..GetKey($translate(h, J, r), 1)
      set CURR1 = $p(nkey, "^")

      if ((CURR1 > BEST1)) {
        set BEST1 = CURR1
      }
    }
    set sorted(BEST1, BEST2, i) = c
  }

  set x = "", rank = 1
  for {
    set x = $o(sorted(x))
    if (x = "") {
      quit
    }
    set y = ""
    for {
      set y = $o(sorted(x, y))
      if (y = "") {
        quit
      }
      set z = ""
      for {
        set z = $o(sorted(x, y, z), 1, c)
        if (z = "") {
          quit
        }
        set res = res + (rank * c)
        set rank = rank + 1
      }
    }
  }

  return res
}

}
