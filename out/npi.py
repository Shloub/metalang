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


def is_number(c):
    return ord(c) <= ord('9') and ord(c) >= ord('0')
"""Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI"""
def npi0(str, len):
    stack = [0] * len
    ptrStack = 0
    ptrStr = 0
    while ptrStr < len:
        if str[ptrStr] == ' ':
            ptrStr += 1
        elif is_number(str[ptrStr]):
            num = 0
            while str[ptrStr] != ' ':
                num = num * 10 + ord(str[ptrStr]) - ord('0')
                ptrStr += 1
            stack[ptrStack] = num
            ptrStack += 1
        elif str[ptrStr] == '+':
            stack[ptrStack - 2] += stack[ptrStack - 1]
            ptrStack -= 1
            ptrStr += 1
    return stack[0]
len = 0
len = readint()
stdinsep()
tab = [None] * len
for i in range(0, len):
    tmp = '\u0000'
    tmp = readchar()
    tab[i] = tmp
result = npi0(tab, len)
print("%d" % result, end='')

