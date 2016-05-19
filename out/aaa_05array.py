import math
def mod(x, y):
    return x - y * math.trunc(x / y)

def id(b):
    return b

def g(t, index):
    t[index] = False

j = 0
a = [None] * 5
for i in range(0, 5):
    print("%d" % i, end='')
    j += i
    a[i] = mod(i, 2) == 0
print("%d " % (j), end='')
if a[0]:
    print("True", end='')
else:
    print("False", end='')
print("")
g(id(a), 0)
if a[0]:
    print("True", end='')
else:
    print("False", end='')
print("")

