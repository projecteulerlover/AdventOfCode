Class dc.AoC2023.day12 Extends dc.AoC2023.base
{

ClassMethod Solve(ByRef DP, ByRef PATTERN, ByRef STATE, i, j) As %Status [ ProcedureBlock = 1 ]
{
  if (i = (PATTERN + 1)) {
    return (j = (STATE + 1))
  }
  if ($d(DP(i, j), targ)) {
    return targ
  }
  set res = 0
  set c = PATTERN(i)
  if ((c = ".") || (c = "?")) {
    set res = res + ..Solve(.DP, .PATTERN, .STATE, i + 1, j)
  }

  if ((j <= STATE) && ((i + STATE(j)) <= PATTERN)) {
    set ni = i + STATE(j)
    set space = 0
    for k=i:1:..Min(ni - 1, PATTERN) {
      if (PATTERN(k) = ".") {
        set space = 1
        quit
      }
    }
    
    if ('space && (PATTERN(ni) '= "#")) {
      set res = res + ..Solve(.DP, .PATTERN, .STATE, ni + 1, j + 1)
    }
  }
  set DP(i, j) = res
  return res
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/12.in", .ls)

  set sum = 0
  for i=1:1:ls {
    set p = $p(ls(i), " ")_"?", s = $p(ls(i), " ", 2)
    set lp = $length(p), ls = $length(s, ",") 
    set P = lp
    for j=1:1:lp {
      set P(j) = $e(p, j)
    }
    set S = ls
    for j=1:1:ls {
      set S(j) = $p(s, ",", j)
    }
    
    kill dp
    set dp = ""
    set sum = sum + ..Solve(.dp, .P, .S, 1, 1)
  }

  return sum
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/12.in", .ls)

  set sum = 0
  for i=1:1:ls {
    set p = $p(ls(i), " ")_"?", s = $p(ls(i), " ", 2)
    set lp = $length(p), ls = $length(s, ",") 
    set P = lp
    for t=0:1:4 {
      for j=1:1:lp {
        set P(t * lp + j) = $e(p, j)
      }
      set S = ls
      for j=1:1:ls {
        set S(t * ls + j) = $p(s, ",", j)
      }
    }
    
    set P = P * 5, S = S * 5
    kill dp
    set dp = ""
    set sum = sum + ..Solve(.dp, .P, .S, 1, 1)
  }

  return sum
}

}
