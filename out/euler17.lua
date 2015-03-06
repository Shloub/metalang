

function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end

buffer =  ""
function readint()
    if buffer == "" then buffer = io.read("*line") end
    local num, buffer0 = string.match(buffer, '^([\-0-9]*)(.*)')
    buffer = buffer0
    return tonumber(num)
end

function readchar()
    if buffer == "" then buffer = io.read("*line") end
    local c = string.byte(buffer)
    buffer = string.sub(buffer, 2, -1)
    return c
end

function stdinsep()
    if buffer == "" then buffer = io.read("*line") end
    if buffer ~= nil then buffer = string.gsub(buffer, '^%s*', "") end
end



local one = 3
local two = 3
local three = 5
local four = 4
local five = 4
local six = 3
local seven = 5
local eight = 5
local nine = 4
local ten = 3
local eleven = 6
local twelve = 6
local thirteen = 8
local fourteen = 8
local fifteen = 7
local sixteen = 7
local seventeen = 9
local eighteen = 8
local nineteen = 8
local twenty = 6
local thirty = 6
local forty = 5
local fifty = 5
local sixty = 5
local seventy = 7
local eighty = 6
local ninety = 6
local hundred = 7
local thousand = 8
io.write(string.format("%d\n", one + two + three + four + five))
local hundred_and = 10
local one_to_nine = one + two + three + four + five + six + seven + eight + nine
io.write(string.format("%d\n", one_to_nine))
local one_to_ten = one_to_nine + ten
local one_to_twenty = one_to_ten + eleven + twelve + thirteen + fourteen + fifteen + sixteen + seventeen + eighteen + nineteen + twenty
local one_to_thirty = one_to_twenty + twenty * 9 + one_to_nine + thirty
local one_to_forty = one_to_thirty + thirty * 9 + one_to_nine + forty
local one_to_fifty = one_to_forty + forty * 9 + one_to_nine + fifty
local one_to_sixty = one_to_fifty + fifty * 9 + one_to_nine + sixty
local one_to_seventy = one_to_sixty + sixty * 9 + one_to_nine + seventy
local one_to_eighty = one_to_seventy + seventy * 9 + one_to_nine + eighty
local one_to_ninety = one_to_eighty + eighty * 9 + one_to_nine + ninety
local one_to_ninety_nine = one_to_ninety + ninety * 9 + one_to_nine
io.write(string.format("%d\n%d\n", one_to_ninety_nine, 100 * one_to_nine + one_to_ninety_nine * 10 + hundred_and * 9 * 99 + hundred * 9 + one + thousand))
