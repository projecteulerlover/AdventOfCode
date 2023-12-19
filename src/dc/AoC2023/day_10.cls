Class dc.AoC2023.day10 Extends dc.AoC2023.base
{

ClassMethod GetInputs(ByRef input, ByRef G, ByRef D, ByRef M, ByRef sr, ByRef sc) As %Status [ ProcedureBlock = 1 ]
{
  set G = input
  for i=1:1:input {
    set G(i) = $length(input(i))
    for j=1:1:G(i) {
      set G(i, j) = $e(input(i), j)      
      if (G(i, j) = "S") {
        set sr = i, sc = j
      }
    }
  }

  set D(0) = "0^1"
  set D(1) = "1^0"
  set D(2) = "0^-1"
  set D(3) = "-1^0"

	set M(0,"-") = 0
	set M(0,"7") = 1
	set M(0,"J") = 3
	set M(2,"-") = 2
	set M(2,"F") = 1
	set M(2,"L") = 3
	set M(1,"|") = 1
	set M(1,"L") = 0
	set M(1,"J") = 2
	set M(3,"|") = 3
	set M(3,"F") = 0
	set M(3,"7") = 2
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/10.in", .input)
  set G = "", M = "", D = "", sr = "", sc = ""
  d ..GetInputs(.input, .G, .D, .M, .sr, .sc)

  set R = G, C = G(1)
  set vs = ""

  for d = 0:1:3 {
    set dr = $p(D(d), "^"), dc = $p(D(d), "^", 2)
    set r = sr + dr, c = sc + dc
    set cd = d
    kill vs

    if ((r < 1) || (r > R) || (c < 1) || (c > C)) {
      continue
    }

    set ok = 1
    set dist = 1
    while (((r '= sr) || (c '= sc)) && '$d(vs(r, c))) {
      if ('((r < 1) || (r > R) || (c < 1) || (c > C)) && $d(M(cd, G(r, c)), cd)) {
        set vs(r, c) = ""
        set dr = $p(D(cd), "^"), dc = $p(D(cd), "^", 2)
        set r = r + dr, c = c + dc
        set dist = dist + 1
      } else {
        set ok = 0
        quit
      }
    }

    if (ok && (r = sr) && (c = sc)) {
      return dist \ 2
    }
  }

  return -1
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/10.in", .input)
  set G = "", M = "", D = "", sr = "", sc = ""
  d ..GetInputs(.input, .G, .D, .M, .sr, .sc)

  set R = G, C = G(1)
  set vs = "", b = 0

  for d = 0:1:3 {
    set dr = $p(D(d), "^"), dc = $p(D(d), "^", 2)
    set r = sr + dr, c = sc + dc
    set cd = d
    kill vs, corners

    if ((r < 1) || (r > R) || (c < 1) || (c > C)) {
      continue
    }

    set ok = 1
    set dist = 1
    set corners = 1
    set corners(1) = sr_" "_sc
    set turns("L") = "", turns("J") = "", turns("7") = "", turns("F") = ""
    while (((r '= sr) || (c '= sc)) && '$d(vs(r, c))) {
      if ('((r < 1) || (r > R) || (c < 1) || (c > C)) && $d(M(cd, G(r, c)), cd)) {
        set vs(r, c) = ""
        if ($d(turns(G(r, c)))) {
          set corners = corners + 1
          set corners(corners) = r_" "_c
        }
        set dr = $p(D(cd), "^"), dc = $p(D(cd), "^", 2)
        set r = r + dr, c = c + dc
        set dist = dist + 1
      } else {
        set ok = 0
        quit
      }
    }

    if (ok && (r = sr) && (c = sc)) {
      set b = dist
      quit
    }
  }
  return ..Shoelace(.corners) - (b \ 2) + 1
}

}
