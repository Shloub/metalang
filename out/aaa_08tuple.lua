
function readintline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), "-?%d+") do
    tab[i] = tonumber(a)
    i = i + 1
  end
  return tab
end



local bar_ = tonumber(io.read('*l'))
local c = readintline()
local d = {
  tuple_int_int_field_0=c[0],
  tuple_int_int_field_1=c[1]
}
local t = {
  foo=d,
  bar=bar_
}
local e = t.foo
local a = e.tuple_int_int_field_0
local b = e.tuple_int_int_field_1
io.write(string.format("%d %d %d\n", a, b, t.bar))
