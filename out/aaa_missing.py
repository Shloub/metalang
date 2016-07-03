
"""Ce test a été généré par Metalang."""
def result(len, tab):
    tab2 = [False] * len
    for i1 in range(0, len):
        print("%d " % tab[i1], end='')
        tab2[tab[i1]] = True
    print("\n", end='')
    for i2 in range(0, len):
        if not tab2[i2]:
            return i2
    return -1

len = int(input())
print("%d\n" % len, end='')
tab = list(map(int, input().split()))
print("%d\n" % result(len, tab), end='')

