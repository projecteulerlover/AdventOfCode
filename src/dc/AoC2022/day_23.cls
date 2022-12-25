Class dc.AoC2022.day23 Extends dc.AoC2022.base
{

ClassMethod shouldMove(r, c, ByRef elves) [ ProcedureBlock = 1 ]
{
  for nr=r-1:1:r+1 {
    for nc=c-1:1:c+1 {
      if ((nr = r) && (nc = c)) continue
      if ($d(elves(nr_" "_nc))) return 1
    }
  }
  return 0
}

ClassMethod move(d, r, c, ByRef elves) [ ProcedureBlock = 1 ]
{
  if ('..shouldMove(r, c, .elves)) return r_" "_c
  if ((d = "N") && '$d(elves((r-1)_" "_(c-1))) && '$d(elves((r-1)_" "_(c))) && '$d(elves((r-1)_" "_(c+1)))) {
    return (r-1)_" "_c
  }
  if ((d = "S") && '$d(elves((r+1)_" "_(c-1))) && '$d(elves((r+1)_" "_(c))) && '$d(elves((r+1)_" "_(c+1)))) {
    return (r+1)_" "_c
  }
  if ((d = "W") && '$d(elves((r-1)_" "_(c-1))) && '$d(elves((r)_" "_(c-1))) && '$d(elves((r+1)_" "_(c-1)))) {
    return r_" "_(c-1)
  }
  if ((d = "E") && '$d(elves((r-1)_" "_(c+1))) && '$d(elves((r)_" "_(c+1))) && '$d(elves((r+1)_" "_(c+1)))) {
    return r_" "_(c+1)
  }
  return r_" "_c
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2022/23.in", .ls)
  set elves = "", m = ls, n = $length(ls(1))
  for r=1:1:m {
    for c=1:1:n {
      if ($e(ls(r), c) = "#") set elves(r_" "_c) = ""
    }
  }
  set dirs = 3, dirs(0) = "N", dirs(1) = "S", dirs(2) = "W", dirs(3) = "E"
  for t=0:1:9 {
    kill newElves, proposal, proposalCount
    set coords = ""
    for {
      set coords = $o(elves(coords))
      if (coords = "") quit
      set found = 0
      for i=0:1:3 {
        set d = dirs((t + i) # 4)
        set r = $p(coords, " "), c = $p(coords, " ", 2)
        set ncoords = ..move(d, r, c, .elves)
        if (ncoords '= coords) {
          set proposalCount(ncoords) = $g(proposalCount(ncoords), 0) + 1
          set proposal(coords) = ncoords
          set found = 1
          quit
        }
      }
      if ('found) {
        set proposalCount(coords) = $g(proposalCount(coords), 0) + 1
        set proposal(coords) = coords
      }
    }
    set coords = ""
    for {
      set coords = $o(proposal(coords), 1, ncoords)
      if (coords = "") quit

      if (proposalCount(ncoords) = 1) {
        set newElves(ncoords) = ""
      } else {
        set newElves(coords) = ""
      }
    }
    kill elves
    MERGE elves = newElves
  }
  set mr = 10000000, Mr = -10000000, mc = 10000000, Mc = -10000000
  set coords = ""
  for {
    set coords = $order(elves(coords))
    if (coords = "") quit
    set r = $p(coords, " "), c = $p(coords, " ", 2)
    set mr = ..Min(mr, r), Mr = ..Max(Mr, r), mc = ..Min(mc, c), Mc = ..Max(Mc, c)
  }
  set total = 0
  for r=mr:1:Mr {
    for c=mc:1:Mc {
      if ('$d(elves(r_" "_c))) set total = total + 1
    }
  }
  return total
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  zw "This might take awhile."
  d ..Read("/irisdev/app/inputs/2022/23.in", .ls)
  set elves = "", m = ls, n = $length(ls(1))
  for r=1:1:m {
    for c=1:1:n {
      if ($e(ls(r), c) = "#") set elves(r_" "_c) = ""
    }
  }
  set dirs = 3, dirs(0) = "N", dirs(1) = "S", dirs(2) = "W", dirs(3) = "E"
  set t = 0
  while 1 {
    kill newElves, proposal, proposalCount
    set coords = ""
    for {
      set coords = $o(elves(coords))
      if (coords = "") quit
      set found = 0
      for i=0:1:3 {
        set d = dirs((t + i) # 4)
        set r = $p(coords, " "), c = $p(coords, " ", 2)
        set ncoords = ..move(d, r, c, .elves)
        if (ncoords '= coords) {
          set proposalCount(ncoords) = $g(proposalCount(ncoords), 0) + 1
          set proposal(coords) = ncoords
          set found = 1
          quit
        }
      }
      if ('found) {
        set proposalCount(coords) = $g(proposalCount(coords), 0) + 1
        set proposal(coords) = coords
      }
    }
    set coords = "", moved = 0
    for {
      set coords = $o(proposal(coords), 1, ncoords)
      if (coords = "") quit

      if (proposalCount(ncoords) = 1) {
        if (ncoords '= coords) set moved = 1
        set newElves(ncoords) = ""
      } else {
        set newElves(coords) = ""
      }
    }
    if ('moved) return t+1
    kill elves
    MERGE elves = newElves
    set t = t + 1
  }
  return -1
}

}
