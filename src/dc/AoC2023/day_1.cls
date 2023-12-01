Class dc.AoC2023.day1 Extends dc.AoC2023.base
{

ClassMethod Part1() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/1.in", .lines)
    set total = 0
    for k = 1:1:lines {
        set ds = []
        set x = lines(k)
        for i = 1:1:$length(x) {
            set c = $extract(x, i)
            if c?1N {
                do ds.%Push(+c)
            }
        }
        set total = total + (ds.%Get(0) * 10) + ds.%Get(ds.%Size() - 1)
    }
    return total
}

ClassMethod Part2() As %Status [ ProcedureBlock = 1 ]
{
	d ..Read("/irisdev/app/inputs/2023/1.in", .lines)
    set nums = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    set total = 0
    for k = 1:1:lines {
        set ds = []
        set x = lines(k)
        for i = 1:1:$length(x) {
            set c = $extract(x, i)
            if c?1N {
                do ds.%Push(+c)
            } else {
                for j = 0:1:nums.%Size() - 1 {
                    set num = nums.%Get(j)
                    #; no number is the prefix of another number, so this doesn't need bound checking.
                    if ($extract(x, i, i + $length(num) - 1) = num) {
                        do ds.%Push(j + 1)
                    }
                }
            }
        }
        set total = total + (ds.%Get(0) * 10) + ds.%Get(ds.%Size() - 1)
    }
    return total
}

}
