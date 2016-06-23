import math
def mod(x, y):
    return x - y * math.trunc(x / y)


maximum = 1
b0 = 2
a = 408464633
sqrtia = math.floor(math.sqrt(a))
while a != 1:
    b = b0
    found = False
    while b <= sqrtia:
        if mod(a, b) == 0:
            a = math.trunc(a / b)
            b0 = b
            b = a
            sqrtia = math.floor(math.sqrt(a))
            found = True
        b += 1
    if not found:
        print("%d\n" % a, end='')
        a = 1

