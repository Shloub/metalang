require "scanf.rb"
def f( tuple0 )
  (a, b) = tuple0
  return [a + 1, b + 1]
end
t = f([0, 1])
(a, b) = t
printf "%d -- %d--\n", a, b

