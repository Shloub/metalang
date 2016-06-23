
def test(tab, len):
    for i in range(0, 1 + len - 1):
        print("%d " % tab[i], end='')
    print("\n", end='')

t = [1] * 5
test(t, 5)

