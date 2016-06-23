import math

def result(sum, t, maxIndex, cache):
    if cache[sum][maxIndex] != 0:
        return cache[sum][maxIndex]
    elif sum == 0 or maxIndex == 0:
        return 1
    else:
        out0 = 0
        div = math.trunc(sum / t[maxIndex])
        for i in range(0, 1 + div):
            out0 += result(sum - i * t[maxIndex], t, maxIndex - 1, cache)
        cache[sum][maxIndex] = out0
        return out0

t = [0] * 8
t[0] = 1
t[1] = 2
t[2] = 5
t[3] = 10
t[4] = 20
t[5] = 50
t[6] = 100
t[7] = 200
cache = [None] * 201
for j in range(0, 1 + 201 - 1):
    o = [0] * 8
    cache[j] = o
print("%d" % result(200, t, 7, cache), end='')

