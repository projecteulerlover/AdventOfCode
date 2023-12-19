Class dc.AoC2023.day4 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/4.in", .input)
  d ..RemoveColon(.input)
  set res = 0

  For i = 1:1:input {
    set line = input(i)
    set a = ..GetIntsLine($p(line, "|", 1))
    set b = ..GetIntsLine($p(line, "|", 2))

    kill hand
    set hand = ""
    for j = 1:1:$length(a, " ") {
      set hand($p(a, " ", j)) = $get(hand($p(a, " ", j)), 0) + 1
    }
    for j = 1:1:$length(b, " ") {
      set hand($p(b, " ", j)) = $get(hand($p(b, " ", j)), 0) + 1
    }
    set x = "", v = 0, t = 0, wins = ""
    for {
      set x = $o(hand(x), 1, v)
      if (x = "") {
        quit
      }
      if (v = 2) {
        set wins = wins_" "_x
        set t = t + 1
      }
    }
    if (t) {
      set res = res + $zpower(2, t - 1)
    }
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/4.in", .input)
  d ..RemoveColon(.input)
  set res = 0
  set cards = 0

  For i = 1:1:input {
    set line = input(i)
    set a = ..GetIntsLine($p(line, "|", 1))
    set b = ..GetIntsLine($p(line, "|", 2))
    
    kill hand
    set hand = ""
    for j = 1:1:$length(a, " ") {
      set hand($p(a, " ", j)) = $get(hand($p(a, " ", j)), 0) + 1
    }
    for j = 1:1:$length(b, " ") {
      set hand($p(b, " ", j)) = $get(hand($p(b, " ", j)), 0) + 1
    }
    set x = "", v = 0, t = 0, wins = ""
    for {
      set x = $o(hand(x), 1, v)
      if (x = "") {
        quit
      }
      if (v = 2) {
        set t = t + 1
      }
    }
    set res = res + $get(cards(i), 1)
    for j = 1:1:t {
      set cards(i + j) = $get(cards(i + j), 1) + $get(cards(i), 1)
    }
  }
  return res
}

}
