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


def foo():
    a = 0
    # test 
    
    a += 1
    # test 2 
    
def foo2():
    pass
def foo3():
    if 1 == 1:
        pass
def sumdiv(n):
    # On désire renvoyer la somme des diviseurs 
    
    out0 = 0
    # On déclare un entier qui contiendra la somme 
    
    for i in range(1, n + 1):
        # La boucle : i est le diviseur potentiel
        
        if mod(n, i) == 0:
            # Si i divise 
            
            out0 += i
            # On incrémente 
            
        else:
            pass
    return out0
    #On renvoie out
    
# Programme principal 

n = 0
n = readint()
# Lecture de l'entier 

print("%d" % sumdiv(n), end='')

