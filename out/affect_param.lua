function foo( a )
  a = 4
end


local a = 0
foo(a)
io.write(string.format("%d\n", a))
