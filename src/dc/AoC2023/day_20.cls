Class dc.AoC2023.day20 Extends dc.AoC2023.base
{

ClassMethod Build(ByRef ls, ByRef ff, ByRef co, ByRef bc, ByRef pprx) As %Status [ ProcedureBlock = 1 ]
{
  set prx = ""
  for i=1:1:ls {
    set ls(i) = $TRANSLATE(ls(i), " ", "")
    set l = ls(i)
    set type = $e(l, 1)
    set a = $p(l, "->"), b = $p(l, "->", 2)
    kill arr
    do ..ToArray(.arr, b, ",")
    if (type = "%") {
      set name = $e(a, 2, *)
      set ff(name, 1) = 0
      merge ff(name, 2) = arr
      if ((arr = 1) && (arr(1) = "rx")) {
        set prx = name
      }
    } elseif (type = "&") {
      set name = $e(a, 2, *)
      merge co(name, 2) = arr
      if ((arr = 1) && (arr(1) = "rx")) {
        set prx = name
      }
    } else {
      merge bc = arr
    }
  }

  set par = ""
  for {
    set par = $o(co(par))
    if (par =  "") {
      quit
    }

    for i=1:1:co(par, 2) {
      set node = co(par, 2, i)
      if (node = prx) {
        set pprx(par, "time") = 0
        set pprx(par, "res") = 0
      }
    }
  }

  for i=1:1:ls {
    set l = ls(i)
    set a = $p(l, "->"), b = $p(l, "->", 2)

    if (a '= "broadcaster") {
      set a = $e(a, 2, *)
    }
    for j=1:1:$LENGTH(b, ",") {
      set x = $p(b, ",", j)
      if ($d(co(x))) {
        set co(x, 1, a) = 0
      }
    }
  }
}

ClassMethod Recurse(ByRef q, ByRef res, ByRef ff, ByRef co, ByRef pprx, node, pulse, par, t = 0) As %Status [ ProcedureBlock = 1 ]
{
  if ((pulse = 0) && $d(pprx(node))) {
    if (pprx(node, "time") = 0) {
      set pprx(node, "time") = t
    } elseif (pprx(node, "res") = 0) {
      set pprx(node, "res") = t - pprx(node, "time")
    }
  }
  set res(pulse) = res(pulse) + 1
  if ($d(ff(node))) {
    if (pulse = 0) {
      set ff(node, 1) = 1 - ff(node, 1)
      set np = ff(node, 1)
      for i=1:1:ff(node, 2) {
        set cs = ff(node, 2, i)
        do q.%Push(cs_" "_np_" "_node)
      }
    }
  } elseif ($d(co(node))) {
    set co(node, 1, par) = pulse
    set np = 0, cs = ""
    for {
      set cs = $o(co(node, 1, cs), 1, v)
      if (cs = "") {
        quit
      }
      if ('v) {
        set np = 1
        quit
      }
    }
    for i=1:1:co(node, 2) {
      set cs = co(node, 2, i)
      do q.%Push(cs_" "_np_" "_node)
    }
  }
}

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/20.in", .ls)
  set ff = "", co = "", bc = "", pprx = ""
  d ..Build(.ls, .ff, .co, .bc, .pprx)
  set res(0) = 0, res(1) = 0
  set q = [], qi = 0

  for t=1:1:1000 {
    set res(0) = res(0) + 1
    for i=1:1:bc {
      do q.%Push(bc(i)_" 0 broadcaster")
    }

    while (q.%Size() > qi) {
      set cur = q.%Get(qi)
      set qi = qi + 1
      set node = $p(cur, " "), pulse = $p(cur, " " , 2), par = $p(cur, " ", 3)
      do ..Recurse(.q, .res, .ff, .co, .pprx, node, pulse, par)
    }
  }
  return res(0) * res(1)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
  d ..Read("/irisdev/app/inputs/2023/20.in", .ls)
  set ff = "", co = "", bc = "", pprx = ""
  d ..Build(.ls, .ff, .co, .bc, .pprx)
  set res(0) = 0, res(1) = 0
  set q = [], qi = 0

  for t=1:1:10000 {
    set res(0) = res(0) + 1
    for i=1:1:bc {
      do q.%Push(bc(i)_" 0 broadcaster")
    }

    while (q.%Size() > qi) {
      set cur = q.%Get(qi)
      set qi = qi + 1
      set node = $p(cur, " "), pulse = $p(cur, " " , 2), par = $p(cur, " ", 3)
      do ..Recurse(.q, .res, .ff, .co, .pprx, node, pulse, par, t)
    }
  }

  set res = 1
  set p = ""
  for {
    set p = $o(pprx(p))
    if (p = "") {
      quit
    }
    set res = ..LCM(res, pprx(p, "res"))
  }
  return res
}

}
