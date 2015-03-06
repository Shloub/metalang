
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
