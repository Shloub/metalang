def f( tuple_ ):
    (a, b) = tuple_
    return (a + 1, b + 1);

t = f((0, 1));
(a, b) = t
print("%d -- %d--\n" % ( a, b ), end='')

