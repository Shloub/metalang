
def testA(a, b):
    if a:
        if b:
            print("A", end='')
        else:
            print("B", end='')
    elif b:
        print("C", end='')
    else:
        print("D", end='')
def testB(a, b):
    if a:
        print("A", end='')
    elif b:
        print("B", end='')
    else:
        print("C", end='')
def testC(a, b):
    if a:
        if b:
            print("A", end='')
        else:
            print("B", end='')
    else:
        print("C", end='')
def testD(a, b):
    if a:
        if b:
            print("A", end='')
        else:
            print("B", end='')
        print("C", end='')
    else:
        print("D", end='')
def testE(a, b):
    if a:
        if b:
            print("A", end='')
    else:
        if b:
            print("C", end='')
        else:
            print("D", end='')
        print("E", end='')
def test(a, b):
    testD(a, b)
    testE(a, b)
    print("\n", end='')
test(True, True)
test(True, False)
test(False, True)
test(False, False)

