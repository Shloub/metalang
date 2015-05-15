def f( tuple0 ):
    (a, b) = tuple0
    return [a + 1, b + 1]

t = f([0, 1])
(a, b) = t
print("%d -- %d--\n" % ( a, b ), end='')

