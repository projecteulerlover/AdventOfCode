Class dc.AoC2022.base
{

ClassMethod PrintAllDays(d = 25) [ ProcedureBlock = 1 ]
{
	set ^zTEST = 0 // use my own inputs
	#; comment out one of the following lines to toggle which inputs get run
	#; set ^zTEST = 1 // use test 1 inputs
	#; set ^zTEST = 2 // use test 2 inputs
	for i=1:1:d {
			s curr = $xecute("return "_"##class(dc.AoC2022.day"_i_").Part1()")
			zw "Problem "_i_" Part 1 = "_curr
			s curr = $xecute("return "_"##class(dc.AoC2022.day"_i_").Part2()")
			zw "Problem "_i_" Part 2 = "_curr
			w !
	}
	return "Done."
}

ClassMethod Read(input, ByRef result, case = 0) As %Status [ ProcedureBlock = 1 ]
{
	set file = ##class(%Stream.FileCharacter).%New()
	set testMode = $g(^zTEST, 0)
	if (testMode '= 0) {
		set re = ##class(%Regex.Matcher).%New("/irisdev/app/inputs/2023/([0-9]+)\.in")
		if (re.Match(input) && (testMode = 1)) {
			set input = "/irisdev/app/inputs/2023/test_set_1/"_(re.Group(1))_"/data.txt"
		} elseif (re.Match(input) && (testMode = 2)) {
			set input = "/irisdev/app/inputs/2023/test_set_2/"_(re.Group(1))_"/input.txt"
		}
	}
	s sc = file.LinkToFile(input)
	if ('sc) return sc
	if (case = 0) {
		s i = 0
		while 'file.AtEnd {
			s i = i+1
			s result(i) = $translate(file.ReadLine(), $c(13))
		}
		s result = i
	}
	if (case = 1) {
		s i = 1, j = 1
		while 'file.AtEnd {
			set l = $translate(file.ReadLine(), $c(13))
			if (l = "") {
				s result(i) = j - 1
				s i = i+1, j = 1
				continue 
			}
			s result(i, j) = l
			s j = j + 1
		}
		s result(i) = j - 1
		s result = i
	}
	if (case = 2) {
		s i = 1
		while 'file.AtEnd {
			set l = $translate(file.ReadLine(), $c(13))
			set n = $length(l)
			for j=1:1:n {
				set result(i, j) = $e(l, j)
			}
			set result(i) = n
			set i = i+1
		}
		s result = i-1
	}
	return 1
}

ClassMethod Max(a, b) As %Integer [ ProcedureBlock = 1 ]
{
	if (a > b) return a
	return b
}

ClassMethod Min(a, b) As %Integer [ ProcedureBlock = 1 ]
{
	if (a < b) return a
	return b
}

ClassMethod Reverse(s) As %String [ ProcedureBlock = 1 ]
{
	set n = $length(s)
	for i=1:1:n/2 {
		set temp = $e(s, i)
		set $e(s, i) = $e(s, n-i+1)
		set $e(s, n-i+1) = temp
	}
	return s
}

ClassMethod Equal(ByRef a, ByRef b) As %Boolean [ ProcedureBlock = 1 ]
{
	set aptr = ""
	for {
		set aptr = $o(a(aptr))
		if (aptr = "") quit

		if ('$d(b(aptr))) return 0
	}
	set bptr = ""
	for {
		set bptr = $o(b(bptr))
		if (bptr = "") quit

		if ('$d(a(bptr))) return 0
	}
	return 1
}

}
