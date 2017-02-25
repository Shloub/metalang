import sys
char_ = None

def readchar_():
    global char_
    if char_ == None:
        char_ = sys.stdin.read(1)
    return char_

def skipchar():
    global char_
    char_ = None
    return

def readchar():
    out = readchar_()
    skipchar()
    return out

def stdinsep():
    while True:
        c = readchar_()
        if c == '\n' or c == '\t' or c == '\r' or c == ' ':
            skipchar()
        else:
            return

def readint():
    c = readchar_()
    if c == '-':
        sign = -1
        skipchar()
    else:
        sign = 1
    out = 0
    while True:
        c = readchar_()
        if c <= '9' and c >= '0' :
            out = out * 10 + int(c)
            skipchar()
        else:
            return out * sign


def pathfind_aux(cache, tab, x, y, posX, posY):
    if posX == x - 1 and posY == y - 1:
        return 0
    elif posX < 0 or posY < 0 or posX >= x or posY >= y:
        return x * y * 10
    elif tab[posY][posX] == '#':
        return x * y * 10
    elif cache[posY][posX] != -1:
        return cache[posY][posX]
    else:
        cache[posY][posX] = x * y * 10
        val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY)
        val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY)
        val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1)
        val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1)
        out0 = 1 + min(val1, val2, val3, val4)
        cache[posY][posX] = out0
        return out0
def pathfind(tab, x, y):
    cache = [None] * y
    for i in range(0, y):
        tmp = [None] * x
        for j in range(0, x):
            tmp[j] = -1
        cache[i] = tmp
    return pathfind_aux(cache, tab, x, y, 0, 0)
x = 0
y = 0
x = readint()
stdinsep()
y = readint()
stdinsep()
tab = [None] * y
for i in range(0, y):
    tab2 = [None] * x
    for j in range(0, x):
        tmp = '\u0000'
        tmp = readchar()
        tab2[j] = tmp
    stdinsep()
    tab[i] = tab2
result = pathfind(tab, x, y)
print("%d" % result, end='')

