Class dc.AoC2023.day5 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/5.in", .input, 1)
  set input(1, 1) = ..RemoveColonLine(input(1, 1))

  set mn = $zpower(2, 50)

  for s = 1:1:$length(input(1, 1), " ") {
    set seed = $p(input(1, 1), " ", s)
    for i = 2:1:input {
      for j = 2:1:input(i) {
        set targ = $p(input(i, j), " ", 1), l = $p(input(i, j), " ", 2), r = l + $p(input(i, j), " ", 3)
        if ((l <= seed) && (seed < r)) {
          set seed = seed + targ - l
          quit
        }
      }
    }
    set mn = ..Min(mn, seed)
  }

  return mn
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/5.in", .input, 1)
  set input(1, 1) = ..RemoveColonLine(input(1, 1))

  set mn = $zpower(2, 50)

  for s = 1:2:$length(input(1, 1), " ") {
    // left inclusive, right exclusive
    set segs = []
    set next = []
    d segs.%Push($p(input(1, 1), " ", s)_","_($p(input(1, 1), " ", s) + $p(input(1, 1), " ", s + 1)))
    for i = 2:1:input {
      while segs.%Size() {
        set last = segs.%Pop()
        set L = $p(last, ",", 1), R = $p(last, ",", 2)
        set add = 1
        for j = 2:1:input(i) {
          set targ = $p(input(i, j), " ", 1), l = $p(input(i, j), " ", 2), r = l + $p(input(i, j), " ", 3)
          set offset = targ - l
          if ((r <= L) || (R <= l)) {
            continue
          }
          if (L < l) {
            do segs.%Push(L_","_l)
            set L = l
          }
          if (r < R) {
            do segs.%Push(r_","_R)
            set R = r
          }
          do next.%Push((L + offset)_","_(R + offset))
          set add = 0
          quit
        }
        if (add) {
          do next.%Push(L_","_R)
        }
      }
      set segs = next
      set next = []
    }
    for k=0:1:segs.%Size() - 1 {
      set mn = ..Min(mn, $p(segs.%Get(k), ",", 1))
    }
  }

  return mn
}

}
