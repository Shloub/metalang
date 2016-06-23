import math
def mod(x, y):
    return x - y * math.trunc(x / y)


def pgcd(a, b):
    c = min(a, b)
    d = max(a, b)
    reste = mod(d, c)
    if reste == 0:
        return c
    else:
        return pgcd(c, reste)

top = 1
bottom = 1
for i in range(1, 1 + 9):
    for j in range(1, 1 + 9):
        for k in range(1, 1 + 9):
            if i != j and j != k:
                a = i * 10 + j
                b = j * 10 + k
                if a * k == i * b:
                    print("%d/%d\n" % (a, b), end='')
                    top *= a
                    bottom *= b
print("%d/%d\n" % (top, bottom), end='')
p = pgcd(top, bottom)
print("pgcd=%d\n%d\n" % (p, math.trunc(bottom / p)), end='')

