Class dc.AoC2023.day17 Extends dc.AoC2023.base
{

ClassMethod HorizontalMove(ByRef field, ByRef rock, dx) [ ProcedureBlock = 1 ]
{
  merge previous = rock
  set coord = ""
  for {
    set coord = $o(previous(coord))
    if (coord = "") quit
    set x = $p(coord, " "), y = $p(coord, " ", 2)
    if ((x + dx < 0) || (x + dx > 6) || $d(field((x+dx)_" "_y))) return
  }
  kill rock
  for {
    set coord = $o(previous(coord))
    if (coord = "") quit
    set x = $p(coord, " "), y = $p(coord, " ", 2)
    set rock((x + dx)_" "_y) = ""
  }
}

ClassMethod VerticalMove(ByRef field, ByRef rock) [ ProcedureBlock = 1 ]
{
  merge previous = rock
  set coord = ""
  for {
    set coord = $o(previous(coord))
    if (coord = "") quit
    set x = $p(coord, " "), y = $p(coord, " ", 2)
    if ((y - 1 = 0) || $d(field(x_" "_(y-1)))) return 0
  }
  kill rock
  for {
    set coord = $o(previous(coord))
    if (coord = "") quit
    set x = $p(coord, " "), y = $p(coord, " ", 2)
    set rock(x_" "_(y - 1)) = ""
  }
  return 1
}

ClassMethod GetRock(ByRef r, x, y, index) [ ProcedureBlock = 1 ]
{
  set index = index # 5
  if (index = 0) {
    for X=2:1:5 set r(X_" "_y) = ""
  } elseif (index = 1) {
    for X=2:1:4 set r(X_" "_(y+1)) = ""
    for Y=y:1:y+2 set r((x+1)_" "_Y) = ""
  } elseif (index = 2) {
    for X=2:1:4 set r(X_" "_y) = ""
    for Y=y:1:y+2 set r(4_" "_Y) = ""
  } elseif (index = 3) {
    for Y=y:1:y+3 set r(x_" "_Y) = ""
  } else {
    for X=2:1:3 set r(X_" "_y) = "", r(X_" "_(y+1)) = ""
  }
}

ClassMethod HasIntersection(ByRef a, ByRef b) [ ProcedureBlock = 1 ]
{
  set coord = ""
  for {
    set coord = $o(a(coord))
    if (coord = "") quit
    if ($d(b(coord))) return 1
  }
  return 0
}

ClassMethod AddToFieldAndReturnMaxY(ByRef field, ByRef r, msfY) [ ProcedureBlock = 1 ]
{
  set coord = ""
  for {
    set coord = $o(r(coord))
    if (coord = "") quit
    set field(coord) = ""
    set msfY = ..Max(msfY, $p(coord, " ", 2))
  }
  return msfY
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/17.in", .ls)
  set gases = ls(1), msfY = 0, gasInd = 0, field = 0, m = $length(gases), n = 5
  for t=0:1:2021 {
    kill rock
    do ..GetRock(.rock, 2, msfY + 4, t # n)
    while 1 {
      do ..HorizontalMove(.field, .rock, $case($e(gases, gasInd+1),">":1,:-1))
      set gasInd = (gasInd + 1) # m
      set moved = ..VerticalMove(.field, .rock)
      if ('moved) quit
    }
    set msfY = ..AddToFieldAndReturnMaxY(.field, .rock, msfY)
  }
  return msfY
}

ClassMethod GetSerial(ByRef field, msfY) [ ProcedureBlock = 1 ]
{
  set serial = ""
  for y=1:1:..Min(50, msfY) {
    set s = ""
    for x=0:1:6 {
       set s = s_$case($d(field(x_" "_(msfY-y))),1:"#",:".")
    }
    set $list(serial(y)) = s
  }
  return serial
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/17.in", .ls)
  set gases = ls(1), msfY = 0, gasInd = 0, field = 0, m = $length(gases), n = 5
  set histories = 0, t = 0, T = 1000000000000, jump = 0
  while (t < T) {
    kill rock
    do ..GetRock(.rock, 2, msfY + 4, t # n)
    while 1 {
      do ..HorizontalMove(.field, .rock, $case($e(gases, gasInd+1),">":1,:-1))
      set gasInd = (gasInd + 1) # m
      set moved = ..VerticalMove(.field, .rock)
      if ('moved) quit
    }
    set msfY = ..AddToFieldAndReturnMaxY(.field, .rock, msfY)
    set fingerprint = gasInd_" "_(t # n)_" "_..GetSerial(.field, msfY)
    if ($d(histories(fingerprint), targ) && (t > 2022)) {
      set dy = msfY - $p(targ, ","), dt = t - $p(targ, ",", 2)
      set gain = (T - t) \ dt
      set jump = jump + (gain * dy), t = t + (gain * dt)
    }
    set histories(fingerprint) = msfY_","_t
    set t = t + 1
  }
  return msfY + jump
}

}
