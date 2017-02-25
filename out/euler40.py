import math
def mod(x, y):
    return x - y * math.trunc(x / y)


def exp0(a, e):
    o = 1
    for i in range(1, e + 1):
        o *= a
    return o
def e(t, n):
    for i in range(1, 9):
        if n >= t[i] * i:
            n -= t[i] * i
        else:
            nombre = exp0(10, i - 1) + math.trunc(n / i)
            chiffre = i - 1 - mod(n, i)
            return mod(math.trunc(nombre / exp0(10, chiffre)), 10)
    return -1
t = [None] * 9
for i in range(0, 9):
    t[i] = exp0(10, i) - exp0(10, i - 1)
for i2 in range(1, 9):
    print("%d => %d\n" % (i2, t[i2]), end='')
for j in range(0, 81):
    print("%d" % e(t, j), end='')
print("\n", end='')
for k in range(1, 51):
    print("%d" % k, end='')
print("\n", end='')
for j2 in range(169, 221):
    print("%d" % e(t, j2), end='')
print("\n", end='')
for k2 in range(90, 111):
    print("%d" % k2, end='')
print("\n", end='')
out0 = 1
for l in range(0, 7):
    puiss = exp0(10, l)
    v = e(t, puiss - 1)
    out0 *= v
    print("10^%d=%d v=%d\n" % (l, puiss, v), end='')
print("%d\n" % out0, end='')

