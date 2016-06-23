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


"""La suite de fibonaci"""
def fibo0(a, b, i):
    out0 = 0
    a2 = a
    b2 = b
    for j in range(0, 1 + i + 1):
        out0 += a2
        tmp = b2
        b2 += a2
        a2 = tmp
    return out0

a = 0
b = 0
i = 0
a = readint()
stdinsep()
b = readint()
stdinsep()
i = readint()
print("%d" % fibo0(a, b, i), end='')

