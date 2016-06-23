import math
def mod(x, y):
    return x - y * math.trunc(x / y)


a = 1
b = 2
sum = 0
while a < 4000000:
    if mod(a, 2) == 0:
        sum += a
    c = a
    a = b
    b += c
print("%d\n" % sum, end='')

