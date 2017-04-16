import math

def dichofind(len, tab, tofind, a, b):
    if a >= b - 1:
        return a
    else:
        c = math.trunc((a + b) / 2)
        if tab[c] < tofind:
            return dichofind(len, tab, tofind, c, b)
        else:
            return dichofind(len, tab, tofind, a, c)
def process(len, tab):
    size = [None] * len
    for j in range(0, len):
        if j == 0:
            size[j] = 0
        else:
            size[j] = len * 2
    for i in range(0, len):
        k = dichofind(len, size, tab[i], 0, len - 1)
        if size[k + 1] > tab[i]:
            size[k + 1] = tab[i]
    for l in range(0, len):
        print("%d " % size[l], end='')
    for m in range(0, len):
        k = len - 1 - m
        if size[k] != len * 2:
            return k
    return 0
n = int(input())
for i in range(1, n + 1):
    len = int(input())
    print("%d\n" % process(len, list(map(int, input().split()))), end='')

