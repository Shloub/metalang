import math
def mod(x, y):
    return x - y * math.trunc(x / y)


"""We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier,
and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a
1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.


(a * 10 + b) ( c * 100 + d * 10 + e) =
  a * c * 1000 +
  a * d * 100 +
  a * e * 10 +
  b * c * 100 +
  b * d * 10 +
  b * e
  => b != e != b * e % 10 ET
  a != d != (b * e / 10 + b * d + a * e ) % 10"""
def okdigits(ok, n):
    if n == 0:
        return True
    else:
        digit = mod(n, 10)
        if ok[digit]:
            ok[digit] = False
            o = okdigits(ok, math.trunc(n / 10))
            ok[digit] = True
            return o
        else:
            return False

count = 0
allowed = [None] * 10
for i in range(0, 1 + 10 - 1):
    allowed[i] = i != 0
counted = [False] * 100000
for e in range(1, 1 + 9):
    allowed[e] = False
    for b in range(1, 1 + 9):
        if allowed[b]:
            allowed[b] = False
            be = mod(b * e, 10)
            if allowed[be]:
                allowed[be] = False
                for a in range(1, 1 + 9):
                    if allowed[a]:
                        allowed[a] = False
                        for c in range(1, 1 + 9):
                            if allowed[c]:
                                allowed[c] = False
                                for d in range(1, 1 + 9):
                                    if allowed[d]:
                                        allowed[d] = False
                                        # 2 * 3 digits 
                                        
                                        product = (a * 10 + b) * (c * 100 + d * 10 + e)
                                        if not counted[product] and okdigits(allowed, math.trunc(product / 10)):
                                            counted[product] = True
                                            count += product
                                            print("%d " % product, end='')
                                        # 1  * 4 digits 
                                        
                                        product2 = b * (a * 1000 + c * 100 + d * 10 + e)
                                        if not counted[product2] and okdigits(allowed, math.trunc(product2 / 10)):
                                            counted[product2] = True
                                            count += product2
                                            print("%d " % product2, end='')
                                        allowed[d] = True
                                allowed[c] = True
                        allowed[a] = True
                allowed[be] = True
            allowed[b] = True
    allowed[e] = True
print("%d\n" % count, end='')

