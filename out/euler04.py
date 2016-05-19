import math
def mod(x, y):
    return x - y * math.trunc(x / y)

"""(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
a * d + a * e * 10 + a * f * 100 +
10 * (b * d + b * e * 10 + b * f * 100)+
100 * (c * d + c * e * 10 + c * f * 100) =

a * d       + a * e * 10   + a * f * 100 +
b * d * 10  + b * e * 100  + b * f * 1000 +
c * d * 100 + c * e * 1000 + c * f * 10000 =

a * d +
10 * ( a * e + b * d) +
100 * (a * f + b * e + c * d) +
(c * e + b * f) * 1000 +
c * f * 10000"""
def chiffre(c, m):
    if c == 0:
        return mod(m, 10)
    else:
        return chiffre(c - 1, math.trunc(m / 10))

m = 1
for a in range(0, 1 + 9):
    for f in range(1, 1 + 9):
        for d in range(0, 1 + 9):
            for c in range(1, 1 + 9):
                for b in range(0, 1 + 9):
                    for e in range(0, 1 + 9):
                        mul = a * d + 10 * (a * e + b * d) + 100 * (a * f + b * e + c * d) + 1000 * (c * e + b * f) + 10000 * c * f
                        if chiffre(0, mul) == chiffre(5, mul) and chiffre(1, mul) == chiffre(4, mul) and chiffre(2, mul) == chiffre(3, mul):
                            m = max(mul, m)
print("%d\n" % (m), end='')

