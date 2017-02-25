import math
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

def mod(x, y):
    return x - y * math.trunc(x / y)


"""lit un sudoku sur l'entrée standard"""
def read_sudoku():
    out0 = [None] * 9 * 9
    for i in range(0, 9 * 9):
        k = readint()
        stdinsep()
        out0[i] = k
    return out0
"""affiche un sudoku"""
def print_sudoku(sudoku0):
    for y in range(0, 9):
        for x in range(0, 9):
            print("%d " % sudoku0[x + y * 9], end='')
            if mod(x, 3) == 2:
                print(" ", end='')
        print("\n", end='')
        if mod(y, 3) == 2:
            print("\n", end='')
    print("\n", end='')
"""dit si les variables sont toutes différentes"""
"""dit si les variables sont toutes différentes"""
"""dit si le sudoku est terminé de remplir"""
def sudoku_done(s):
    for i in range(0, 81):
        if s[i] == 0:
            return False
    return True
"""dit si il y a une erreur dans le sudoku"""
def sudoku_error(s):
    out1 = False
    for x in range(0, 9):
        out1 = out1 or s[x] != 0 and s[x] == s[x + 9] or s[x] != 0 and s[x] == s[x + 9 * 2] or s[x + 9] != 0 and s[x + 9] == s[x + 9 * 2] or s[x] != 0 and s[x] == s[x + 9 * 3] or s[x + 9] != 0 and s[x + 9] == s[x + 9 * 3] or s[x + 9 * 2] != 0 and s[x + 9 * 2] == s[x + 9 * 3] or s[x] != 0 and s[x] == s[x + 9 * 4] or s[x + 9] != 0 and s[x + 9] == s[x + 9 * 4] or s[x + 9 * 2] != 0 and s[x + 9 * 2] == s[x + 9 * 4] or s[x + 9 * 3] != 0 and s[x + 9 * 3] == s[x + 9 * 4] or s[x] != 0 and s[x] == s[x + 9 * 5] or s[x + 9] != 0 and s[x + 9] == s[x + 9 * 5] or s[x + 9 * 2] != 0 and s[x + 9 * 2] == s[x + 9 * 5] or s[x + 9 * 3] != 0 and s[x + 9 * 3] == s[x + 9 * 5] or s[x + 9 * 4] != 0 and s[x + 9 * 4] == s[x + 9 * 5] or s[x] != 0 and s[x] == s[x + 9 * 6] or s[x + 9] != 0 and s[x + 9] == s[x + 9 * 6] or s[x + 9 * 2] != 0 and s[x + 9 * 2] == s[x + 9 * 6] or s[x + 9 * 3] != 0 and s[x + 9 * 3] == s[x + 9 * 6] or s[x + 9 * 4] != 0 and s[x + 9 * 4] == s[x + 9 * 6] or s[x + 9 * 5] != 0 and s[x + 9 * 5] == s[x + 9 * 6] or s[x] != 0 and s[x] == s[x + 9 * 7] or s[x + 9] != 0 and s[x + 9] == s[x + 9 * 7] or s[x + 9 * 2] != 0 and s[x + 9 * 2] == s[x + 9 * 7] or s[x + 9 * 3] != 0 and s[x + 9 * 3] == s[x + 9 * 7] or s[x + 9 * 4] != 0 and s[x + 9 * 4] == s[x + 9 * 7] or s[x + 9 * 5] != 0 and s[x + 9 * 5] == s[x + 9 * 7] or s[x + 9 * 6] != 0 and s[x + 9 * 6] == s[x + 9 * 7] or s[x] != 0 and s[x] == s[x + 9 * 8] or s[x + 9] != 0 and s[x + 9] == s[x + 9 * 8] or s[x + 9 * 2] != 0 and s[x + 9 * 2] == s[x + 9 * 8] or s[x + 9 * 3] != 0 and s[x + 9 * 3] == s[x + 9 * 8] or s[x + 9 * 4] != 0 and s[x + 9 * 4] == s[x + 9 * 8] or s[x + 9 * 5] != 0 and s[x + 9 * 5] == s[x + 9 * 8] or s[x + 9 * 6] != 0 and s[x + 9 * 6] == s[x + 9 * 8] or s[x + 9 * 7] != 0 and s[x + 9 * 7] == s[x + 9 * 8]
    out2 = False
    for x in range(0, 9):
        out2 = out2 or s[x * 9] != 0 and s[x * 9] == s[x * 9 + 1] or s[x * 9] != 0 and s[x * 9] == s[x * 9 + 2] or s[x * 9 + 1] != 0 and s[x * 9 + 1] == s[x * 9 + 2] or s[x * 9] != 0 and s[x * 9] == s[x * 9 + 3] or s[x * 9 + 1] != 0 and s[x * 9 + 1] == s[x * 9 + 3] or s[x * 9 + 2] != 0 and s[x * 9 + 2] == s[x * 9 + 3] or s[x * 9] != 0 and s[x * 9] == s[x * 9 + 4] or s[x * 9 + 1] != 0 and s[x * 9 + 1] == s[x * 9 + 4] or s[x * 9 + 2] != 0 and s[x * 9 + 2] == s[x * 9 + 4] or s[x * 9 + 3] != 0 and s[x * 9 + 3] == s[x * 9 + 4] or s[x * 9] != 0 and s[x * 9] == s[x * 9 + 5] or s[x * 9 + 1] != 0 and s[x * 9 + 1] == s[x * 9 + 5] or s[x * 9 + 2] != 0 and s[x * 9 + 2] == s[x * 9 + 5] or s[x * 9 + 3] != 0 and s[x * 9 + 3] == s[x * 9 + 5] or s[x * 9 + 4] != 0 and s[x * 9 + 4] == s[x * 9 + 5] or s[x * 9] != 0 and s[x * 9] == s[x * 9 + 6] or s[x * 9 + 1] != 0 and s[x * 9 + 1] == s[x * 9 + 6] or s[x * 9 + 2] != 0 and s[x * 9 + 2] == s[x * 9 + 6] or s[x * 9 + 3] != 0 and s[x * 9 + 3] == s[x * 9 + 6] or s[x * 9 + 4] != 0 and s[x * 9 + 4] == s[x * 9 + 6] or s[x * 9 + 5] != 0 and s[x * 9 + 5] == s[x * 9 + 6] or s[x * 9] != 0 and s[x * 9] == s[x * 9 + 7] or s[x * 9 + 1] != 0 and s[x * 9 + 1] == s[x * 9 + 7] or s[x * 9 + 2] != 0 and s[x * 9 + 2] == s[x * 9 + 7] or s[x * 9 + 3] != 0 and s[x * 9 + 3] == s[x * 9 + 7] or s[x * 9 + 4] != 0 and s[x * 9 + 4] == s[x * 9 + 7] or s[x * 9 + 5] != 0 and s[x * 9 + 5] == s[x * 9 + 7] or s[x * 9 + 6] != 0 and s[x * 9 + 6] == s[x * 9 + 7] or s[x * 9] != 0 and s[x * 9] == s[x * 9 + 8] or s[x * 9 + 1] != 0 and s[x * 9 + 1] == s[x * 9 + 8] or s[x * 9 + 2] != 0 and s[x * 9 + 2] == s[x * 9 + 8] or s[x * 9 + 3] != 0 and s[x * 9 + 3] == s[x * 9 + 8] or s[x * 9 + 4] != 0 and s[x * 9 + 4] == s[x * 9 + 8] or s[x * 9 + 5] != 0 and s[x * 9 + 5] == s[x * 9 + 8] or s[x * 9 + 6] != 0 and s[x * 9 + 6] == s[x * 9 + 8] or s[x * 9 + 7] != 0 and s[x * 9 + 7] == s[x * 9 + 8]
    out3 = False
    for x in range(0, 9):
        out3 = out3 or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] == s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] == s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] == s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 1] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 1] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 1] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 1] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 1] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 1] or s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] != 0 and s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 1] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 2] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 2] or s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] != 0 and s[mod(x, 3) * 3 * 9 + math.trunc(x / 3) * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 2] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 2] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 2] or s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] != 0 and s[(mod(x, 3) * 3 + 1) * 9 + math.trunc(x / 3) * 3 + 2] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 2] or s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] != 0 and s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 2] or s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 1] != 0 and s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 1] == s[(mod(x, 3) * 3 + 2) * 9 + math.trunc(x / 3) * 3 + 2]
    return out1 or out2 or out3
"""résout le sudoku"""
def solve(sudoku0):
    if sudoku_error(sudoku0):
        return False
    if sudoku_done(sudoku0):
        return True
    for i in range(0, 81):
        if sudoku0[i] == 0:
            for p in range(1, 10):
                sudoku0[i] = p
                if solve(sudoku0):
                    return True
            sudoku0[i] = 0
            return False
    return False
sudoku0 = read_sudoku()
print_sudoku(sudoku0)
if solve(sudoku0):
    print_sudoku(sudoku0)
else:
    print("no solution\n", end='')

