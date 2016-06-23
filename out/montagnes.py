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


def montagnes0(tab, len):
    max0 = 1
    j = 1
    i = len - 2
    while i >= 0:
        x = tab[i]
        while j >= 0 and x > tab[len - j]:
            j -= 1
        j += 1
        tab[len - j] = x
        if j > max0:
            max0 = j
        i -= 1
    return max0

len = 0
len = readint()
stdinsep()
tab = [None] * len
for i in range(0, 1 + len - 1):
    x = 0
    x = readint()
    stdinsep()
    tab[i] = x
print("%d" % montagnes0(tab, len), end='')

