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


def nth(tab, tofind, len):
    out0 = 0
    for i in range(0, len):
        if tab[i] == tofind:
            out0 += 1
    return out0

len = 0
len = readint()
stdinsep()
tofind = '\u0000'
tofind = readchar()
stdinsep()
tab = [None] * len
for i in range(0, len):
    tmp = '\u0000'
    tmp = readchar()
    tab[i] = tmp
result = nth(tab, tofind, len)
print("%d" % result, end='')

