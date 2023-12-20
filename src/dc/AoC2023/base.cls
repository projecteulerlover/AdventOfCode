Class dc.AoC2023.base
{

ClassMethod PrintAllDays(d = 25, mode = 0) [ ProcedureBlock = 1 ]
{
	if ((mode '= 0) && (mode '= 1) && (mode '= 2)) {
		return "BAD MODE"
	}
	set ^zTEST = mode
	#; set ^zTEST = 0 // use my own inputs
	#; comment out one of the following lines to toggle which inputs get run
	#; set ^zTEST = 1 // use test 1 inputs
	#; set ^zTEST = 2 // use test 2 inputs
	for i=1:1:d {
			s curr = $xecute("return "_"##class(dc.AoC2023.day"_i_").Part1()")
			zw "Problem "_i_" Part 1 = "_curr
			s curr = $xecute("return "_"##class(dc.AoC2023.day"_i_").Part2()")
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
		if (re.Match(input)) {
			set fn = ""
			if ($length(re.Group(1)) = 1) {
				set fn = "0"_re.Group(1)
			} else {
				set fn = re.Group(1)
			}
			if (testMode = 1) {
				set input = "/irisdev/app/inputs/2023/test_set_1/input"_(fn)_".txt"
			} elseif (testMode = 2) {
				set input = "/irisdev/app/inputs/2023/test_set_2/input2"_(fn)_".txt"
			}
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

ClassMethod RemoveColonLine(a) As %Status [ ProcedureBlock = 1 ]
{
	return $p(a, ": ", 2)
}

ClassMethod RemoveColon(ByRef a) As %Status [ ProcedureBlock = 1 ]
{
	for i = 1:1:a {
		set a(i) = ..RemoveColonLine(a(i))
	}
}

ClassMethod GetIntsLine(a, delim = " ") As %String [ ProcedureBlock = 1 ]
{
	set nl = ""
	for j = 1:1:$LENGTH(a, delim) {
		set token = $p(a, delim, j)
		if ($length(token)) {
			if ($length(nl)) {
				set nl = nl_delim_token
			} else {
				set nl = token
			}
		}
	}
	return nl
}

ClassMethod GetInts(ByRef a, delim = " ") As %Status [ ProcedureBlock = 1 ]
{
	for i = 1:1:a {
		set a(i) = ..GetIntsLine(a(i), delim)
	}
}

ClassMethod GCD(a, b) As %Status [ ProcedureBlock = 1 ]
{
	if (a > b) {
		return ..GCD(b, a)
	}
	if (a = 0) {
		return b
	}
	set rem = b # a
	if (rem = 0) {
		return a
	}
	return ..GCD(rem, a)
}

ClassMethod LCM(a, b) As %Status [ ProcedureBlock = 1 ]
{
	return a * b / ..GCD(a, b)
}

ClassMethod ReverseList(a, delim = " ") As %String [ ProcedureBlock = 1 ]
{
	set N = $length(a, delim)
	set res = ""
	for r=N:-1:1 {
		set R = $p(a, delim, r)
		if ($length(res)) {
			set res = res_delim_R
		} else {
			set res = R
		}
	}

	return res
}

ClassMethod Shoelace(ByRef a, delim = " ") As %Integer [ ProcedureBlock = 1 ]
{
	if (a(a) '= a(1)) {
		set a = a + 1
		set a(a) = a(1)
	}
	set res = 0
	for i=1:1:a-1 {
		set res = res + (($p(a(i), delim, 1) * $p(a(i + 1), delim, 2)) - ($p(a(i + 1), delim, 1) * $p(a(i), delim, 2)))
	}
	return $zabs(res) \ 2
}

ClassMethod ToArray(ByRef arr, s, delim = " ") As %Status [ ProcedureBlock = 1 ]
{
	set arr = $length(s, delim)
	for i=1:1:arr {
		set x = $p(s, delim, i)
		set arr(i) = x
	}
}

}
