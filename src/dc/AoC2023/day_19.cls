Class dc.AoC2023.day19 Extends dc.AoC2023.base
{

ClassMethod Sum(ByRef rating) As %Status [ ProcedureBlock = 1 ]
{
  return rating("x") + rating("m") + rating("a") + rating("s")
}

ClassMethod BuildInput(ByRef ratings, ByRef workflows) As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/19.in", .ls, 1)

  set workflows = ls(1), ratings = ls(2)
  for i=1:1:ls(1) {
    set l = ls(1, i)
    set name = $p(l, "{")
    set rules = $e($p(l, "{", 2), 1, *-1)
    set workflows(name) = $length(rules, ",")
    for j=1:1:workflows(name) {
      set workflows(name, j) = $p(rules, ",", j)
    }
  }

  for i=1:1:ls(2) {
    set l = ls(2, i)
    set items = $e(l, 2, *-1)
    for j=1:1:$length(items, ",") {
      set item = $p(items, ",", j)
      set name = $p(item, "="), value = $p(item, "=", 2)
      set ratings(i, name) = value 
    }
  }
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  set ratings = "", workflows = ""
  do ..BuildInput(.ratings, .workflows)
  set res = 0

  for i=1:1:ratings {
    merge rating = ratings(i)
    set cur = "in"

    while ((cur '= "A") && (cur '= "R")) {
      for j=1:1:workflows(cur) {
        set w = workflows(cur, j)
        if ($length(w, ">") > 1) {
          set a = $p(w, ">"), rest = $p(w, ">", 2)
          set b = $p(rest, ":"), c = $p(rest, ":", 2)
          if (rating(a) > +b) {
            set cur = c 
            quit
          }
        } elseif ($length(w, "<") > 1) {
          set a = $p(w, "<"), rest = $p(w, "<", 2)
          set b = $p(rest, ":"), c = $p(rest, ":", 2)
          if (rating(a) < +b) {
            set cur = c 
            quit
          }
        } else {
          set cur = w
        }
      }
    }
    if (cur = "A") {
      set res = res + ..Sum(.rating)
    }
  }

  return res
}

ClassMethod GetRangeSize(range) As %Status [ ProcedureBlock = 1 ]
{
  set res = 1
  for i=1:2:7 {
    set l = $p(range, " ", i), r = 1 + $p(range, " ", i + 1)
    set res = res * (r - l)
  }
  return res
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  set ratings = "", workflows = ""
  do ..BuildInput(.ratings, .workflows)
  set res = 0

  set q = []
  do q.%Push("1 4000 1 4000 1 4000 1 4000 in")
  
  set inds("x") = 1, inds("m") = 3, inds("a") = 5, inds("s") = 7
  
  while (q.%Size()) {
    set u = q.%Pop()
    set name = $p(u, " ", 9)
    if (name = "R") {
      continue
    }
    
    if (name = "A") {
      set res = res + ..GetRangeSize(u)
      continue
    }

    for i=1:1:workflows(name) {
      set w = workflows(name, i)
      if ($length(w, ">") > 1) {
          set a = $p(w, ">"), rest = $p(w, ">", 2)
          set b = $p(rest, ":"), c = $p(rest, ":", 2)
          set good = u
          // intersect [l, r] with [b + 1, inf]
          set $p(good, " ", inds(a)) = ..Max($p(u, " ", inds(a)), b + 1)
          set $p(good, " ", 9) = c
          if ($p(good, " ", inds(a)) <= $p(good, " ", inds(a) + 1)) {
            do q.%Push(good)
          }

          // intersect [l, r] with [-inf, b]
          set $p(u, " ", inds(a) + 1) = ..Min($p(u, " ", inds(a) + 1), b)
        } elseif ($length(w, "<") > 1) {
          set a = $p(w, "<"), rest = $p(w, "<", 2)
          set b = $p(rest, ":"), c = $p(rest, ":", 2)

          set good = u
          // intersect [l, r] with [-inf, b - 1]
          set $p(good, " ", inds(a) + 1) = ..Min($p(u, " ", inds(a) + 1), b - 1)
          set $p(good, " ", 9) = c
          if ($p(good, " ", inds(a)) <= $p(good, " ", inds(a) + 1)) {
            do q.%Push(good)
          }

          // intersect [l, r] with [b, inf]
          set $p(u, " ", inds(a)) = ..Max($p(u, " ", inds(a)), b)
        } else {
          // transition without changing rating intervals
          set $p(u, " ", 9) = w
          do q.%Push(u)
        }
    }
  }

  return res
}

}
