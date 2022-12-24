Class dc.AoC2022.base
{

ClassMethod Read(input, result, case = 0) As %Status [ ProcedureBlock = 1 ]
{
	set file = ##class(%Stream.FileCharacter).%New()
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
