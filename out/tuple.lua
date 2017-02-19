function f (tuple0)
  a, b = unpack(tuple0)
  return {a + 1, b + 1}
end

local t = f({0, 1})
a, b = unpack(t)
io.write(string.format("%d -- %d--\n", a, b))
