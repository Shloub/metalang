require "scanf.rb"
def f( tuple_ )
    (a, b) = tuple_
    return ([a + 1, b + 1]);
end

t = f([0, 1])
(a, b) = t
printf "%d -- %d--\n", a, b

