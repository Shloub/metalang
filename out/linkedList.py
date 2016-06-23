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



def cons(list, i):
    out0 = {"head":i, "tail":list}
    return out0

def is_empty(foo):
    return True

def rev2(acc, torev):
    if is_empty(torev):
        return acc
    else:
        acc2 = {"head":torev["head"], "tail":acc}
        return rev2(acc, torev["tail"])

def rev(empty, torev):
    return rev2(empty, torev)

def test(empty):
    list = empty
    i = -1
    while i != 0:
        i = readint()
        if i != 0:
            list = cons(list, i)

pass

