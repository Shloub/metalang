import math
def mod(x, y):
    return x - y * math.trunc(x / y)


def palindrome2(pow2, n):
    t = [None] * 20
    for i in range(0, 1 + 20 - 1):
        t[i] = mod(math.trunc(n / pow2[i]), 2) == 1
    nnum = 0
    for j in range(1, 1 + 19):
        if t[j]:
            nnum = j
    for k in range(0, 1 + math.trunc(nnum / 2)):
        if t[k] != t[nnum - k]:
            return False
    return True

p = 1
pow2 = [None] * 20
for i in range(0, 1 + 20 - 1):
    p *= 2
    pow2[i] = math.trunc(p / 2)
sum = 0
for d in range(1, 1 + 9):
    if palindrome2(pow2, d):
        print("%d\n" % d, end='')
        sum += d
    if palindrome2(pow2, d * 10 + d):
        print("%d\n" % (d * 10 + d), end='')
        sum += d * 10 + d
for a0 in range(0, 1 + 4):
    a = a0 * 2 + 1
    for b in range(0, 1 + 9):
        for c in range(0, 1 + 9):
            num0 = a * 100000 + b * 10000 + c * 1000 + c * 100 + b * 10 + a
            if palindrome2(pow2, num0):
                print("%d\n" % num0, end='')
                sum += num0
            num1 = a * 10000 + b * 1000 + c * 100 + b * 10 + a
            if palindrome2(pow2, num1):
                print("%d\n" % num1, end='')
                sum += num1
        num2 = a * 100 + b * 10 + a
        if palindrome2(pow2, num2):
            print("%d\n" % num2, end='')
            sum += num2
        num3 = a * 1000 + b * 100 + b * 10 + a
        if palindrome2(pow2, num3):
            print("%d\n" % num3, end='')
            sum += num3
print("sum=%d\n" % sum, end='')

