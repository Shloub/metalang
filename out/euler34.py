
f = [1] * 10
for i in range(1, 10):
    f[i] *= i * f[i - 1]
    print("%d " % f[i], end='')
out0 = 0
print("\n", end='')
for a in range(0, 10):
    for b in range(0, 10):
        for c in range(0, 10):
            for d in range(0, 10):
                for e in range(0, 10):
                    for g in range(0, 10):
                        sum = f[a] + f[b] + f[c] + f[d] + f[e] + f[g]
                        num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g
                        if a == 0:
                            sum -= 1
                            if b == 0:
                                sum -= 1
                                if c == 0:
                                    sum -= 1
                                    if d == 0:
                                        sum -= 1
                        if sum == num and sum != 1 and sum != 2:
                            out0 += num
                            print("%d " % num, end='')
print("\n%d\n" % out0, end='')

