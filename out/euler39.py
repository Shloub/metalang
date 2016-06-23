import math

t = [0] * 1001
for a in range(1, 1 + 1000):
    for b in range(1, 1 + 1000):
        c2 = a * a + b * b
        c = math.floor(math.sqrt(c2))
        if c * c == c2:
            p = a + b + c
            if p <= 1000:
                t[p] += 1
j = 0
for k in range(1, 1 + 1000):
    if t[k] > t[j]:
        j = k
print("%d" % j, end='')

