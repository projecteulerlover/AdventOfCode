Class dc.AoC2022.day1 Extends dc.AoC2022.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/1.in", .input)
    set x = 0, vs = 0
    for i=1:1:input {
        set x = x + input(i)
        if (input(i) = "") {
            set vs(x) = $g(vs(x), 0) + 1
            set x = 0
        }
    }
    return $order(vs(""), -1)
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/1.in", .input)
    set x = 0, vs = 0
    for i=1:1:input {
        set x = x + input(i)
        if (input(i) = "") {
            set vs(x) = $g(vs(x), 0) + 1
            set x = 0
        }
    }
    set y = 3, total = 0, c = ""
    for i=1:1:3 {
        set c = $order(vs(c), -1, t)
        while ((y > 0) && (t > 0)) {
            set total = total + c
            set y = y - 1
            set t = t - 1
        }
    }
    return total
}

}
