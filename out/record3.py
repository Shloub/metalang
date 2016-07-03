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



def mktoto(v1):
    t = {"foo":v1, "bar":0, "blah":0}
    return t

def result(t, len):
    out0 = 0
    for j in range(0, len):
        t[j]["blah"] += 1
        out0 = out0 + t[j]["foo"] + t[j]["blah"] * t[j]["bar"] + t[j]["bar"] * t[j]["foo"]
    return out0

t = [None] * 4
for i in range(0, 4):
    t[i] = mktoto(i)
t[0]["bar"] = readint()
stdinsep()
t[1]["blah"] = readint()
titi = result(t, 4)
print("%d%d" % (titi, t[2]["blah"]), end='')

