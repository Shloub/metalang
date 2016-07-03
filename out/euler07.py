import math
def mod(x, y):
    return x - y * math.trunc(x / y)


def divisible(n, t, size):
    for i in range(0, size):
        if mod(n, t[i]) == 0:
            return True
    return False

def find(n, t, used, nth):
    while used != nth:
        if divisible(n, t, used):
            n += 1
        else:
            t[used] = n
            n += 1
            used += 1
    return t[used - 1]

n = 10001
t = [2] * n
print("%d\n" % find(3, t, 1, n), end='')

