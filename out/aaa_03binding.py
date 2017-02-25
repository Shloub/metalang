import math
def mod(x, y):
    return x - y * math.trunc(x / y)


def g(i):
    j = i * 4
    if mod(j, 2) == 1:
        return 0
    return j
def h(i):
    print("%d\n" % i, end='')
h(14)
a = 4
b = 5
print("%d" % (a + b), end='')
# main 

h(15)
a = 2
b = 1
print("%d" % (a + b), end='')

