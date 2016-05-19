import math
print("Hello World", end='')
a = 5
print("%d \n%dfoo" % ((4 + 6) * 2, a), end='')
if 1 + math.trunc((1 + 1) * 2 * (3 + 8) / 4) - (1 - 2) - 3 == 12 and True:
    print("True", end='')
else:
    print("False", end='')
print("")
if (3 * (4 + 5 + 6) * 2 == 45) == False:
    print("True", end='')
else:
    print("False", end='')
print(" ", end='')
if (2 == 1) == False:
    print("True", end='')
else:
    print("False", end='')
print(" %d%d" % (math.trunc(math.trunc((4 + 1) / 3) / (2 + 1)), math.trunc(math.trunc(4 * 1 / 3) / 2 * 1)), end='')
if not (not (a == 0) and not (a == 4)):
    print("True", end='')
else:
    print("False", end='')
if True and not False and not (True and False):
    print("True", end='')
else:
    print("False", end='')
print("")

