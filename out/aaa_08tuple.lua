buffer =  ""
function readint()
    if buffer == "" then buffer = io.read("*line") end
    local num, buffer0 = string.match(buffer, '^([\-0-9]*)(.*)')
    buffer = buffer0
    return tonumber(num)
end

function stdinsep()
    if buffer == "" then buffer = io.read("*line") end
    if buffer ~= nil then buffer = string.gsub(buffer, '^%s*', "") end
end



local bar_ = readint()
stdinsep()
local c = readint()
stdinsep()
local d = readint()
stdinsep()
local e = {
  tuple_int_int_field_0=c,
  tuple_int_int_field_1=d
}
local t = {
  foo=e,
  bar=bar_
}
local f = t.foo
local a = f.tuple_int_int_field_0
local b = f.tuple_int_int_field_1
io.write(string.format("%d %d %d\n", a, b, t.bar))
