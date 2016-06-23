import math
def mod(x, y):
    return x - y * math.trunc(x / y)


sum = 0
for i in range(0, 1 + 999):
    if mod(i, 3) == 0 or mod(i, 5) == 0:
        sum += i
print("%d\n" % sum, end='')

