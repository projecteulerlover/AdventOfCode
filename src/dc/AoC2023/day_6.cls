Class dc.AoC2023.day6 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/6.in", .input)
  set w = input(1)
  set n = $length(w)
  for i=1:1:n-4 {
    kill fm
    set good = 1
    for j=0:1:3 {
      if ($d(fm($e(w, i+j)))) {
        set good = 0
        continue
      }
      set fm($e(w, i+j)) = ""
    }
    if (good) return i+j
  }
  return -1
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/6.in", .input)
  set w = input(1)
  set n = $length(w)
  for i=1:1:n-14 {
    kill fm
    set good = 1
    for j=0:1:13 {
      if ($d(fm($e(w, i+j)))) {
        set good = 0
        continue
      }
      set fm($e(w, i+j)) = ""
    }
    if (good) return i+j
  }
  return -1
}

}
