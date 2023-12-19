Class dc.AoC2023.day3 Extends dc.AoC2023.base
{

ClassMethod Helper(c) As %Integer [ ProcedureBlock = 1 ]
{
  set x = $ascii(c)
  if (($ascii("a") <= x) && (x <= $ascii("z"))) {
    return x - $ascii("a") + 1
  }
  return x - $ascii("A") + 27
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/3.in", .input)
  set res = 0
  set R = input, C = $LENGTH(input(1))
  for i=1:1:R {
    set line = input(i)
    set num = 0
    set counts = 0
    for j=1:1:C {
      set c = $extract(line, j)
      if c?1N {
        set num = num * 10 + (+c)
        for di = -1:1:1 {
          for dj = -1:1:1 {
            set ni = i + di, nj = j + dj
            if ((1 <= ni) && (ni <= R) && (1 <= nj) && (nj <= C)) {
              set cc = $extract(input(ni), nj)
              if ((cc '= ".") && '(cc?1N)) {
                set counts = 1
              }
            }
          }
        }
      }
      if ('(c?1N) || (j = C)) {
        if (counts) {
          set res = res + num
          set counts = 0
        }
        set num = 0
      }
    }
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/3.in", .input)
  set res = 0
  set R = input, C = $LENGTH(input(1))
  set mults = ""

  for i=1:1:R {
    set line = input(i)
    set num = 0
    set mult = 0
    for j=1:1:C {
      set c = $extract(line, j)
      if c?1N {
        set num = num * 10 + (+c)
        for di = -1:1:1 {
          for dj = -1:1:1 {
            set ni = i + di, nj = j + dj
            if ((1 <= ni) && (ni <= R) && (1 <= nj) && (nj <= C)) {
              set cc = $extract(input(ni), nj)
              if ((cc '= ".") && '(cc?1N)) {
                if (cc = "*") {
                  set mult = ni_"^"_nj
                }
              }
            }
          }
        }
      }
      if ('(c?1N) || (j = C)) {
        if (mult) {
          set mults(mult) = $get(mults(mult), "")
          set $p(mults(mult), ",", $length(mults(mult), ",") + 1) = num
          if ($length(mults(mult), ",") = 3) {
            set res = res + ($p(mults(mult), ",", 2) * $p(mults(mult), ",", 3))
          }
          set mult = 0
        }
        set num = 0
      }
    }
  }
  return res
}

}
