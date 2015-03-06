

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



function f( tuple0 )
  local c = tuple0
  local a = c.tuple_int_int_field_0
  local b = c.tuple_int_int_field_1
  local d = {
    tuple_int_int_field_0=a + 1,
    tuple_int_int_field_1=b + 1
  }
  return d
end


local e = {
  tuple_int_int_field_0=0,
  tuple_int_int_field_1=1
}
local t = f(e)
local g = t
local a = g.tuple_int_int_field_0
local b = g.tuple_int_int_field_1
io.write(string.format("%d -- %d--\n", a, b))
