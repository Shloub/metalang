import math
def mod(x, y):
    return x - y * math.trunc(x / y)



#
#The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
#
#Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:
#
#d2d3d4=406 is divisible by 2
#d3d4d5=063 is divisible by 3
#d4d5d6=635 is divisible by 5
#d5d6d7=357 is divisible by 7
#d6d7d8=572 is divisible by 11
#d7d8d9=728 is divisible by 13
#d8d9d10=289 is divisible by 17
#Find the sum of all 0 to 9 pandigital numbers with this property.
#
#d4 % 2 == 0
#(d3 + d4 + d5) % 3 == 0
#d6 = 5 ou d6 = 0
#(d5 * 100 + d6 * 10 + d7  ) % 7 == 0
#(d6 * 100 + d7 * 10 + d8  ) % 11 == 0
#(d7 * 100 + d8 * 10 + d9  ) % 13 == 0
#(d8 * 100 + d9 * 10 + d10 ) % 17 == 0
#
#
#d4 % 2 == 0
#d6 = 5 ou d6 = 0
#
#(d3 + d4 + d5) % 3 == 0
#(d5 * 2 + d6 * 3 + d7) % 7 == 0
#

allowed = [True] * 10
for i6 in range(0, 2):
    d6 = i6 * 5
    if allowed[d6]:
        allowed[d6] = False
        for d7 in range(0, 10):
            if allowed[d7]:
                allowed[d7] = False
                for d8 in range(0, 10):
                    if allowed[d8]:
                        allowed[d8] = False
                        for d9 in range(0, 10):
                            if allowed[d9]:
                                allowed[d9] = False
                                for d10 in range(1, 10):
                                    if allowed[d10] and mod(d6 * 100 + d7 * 10 + d8, 11) == 0 and mod(d7 * 100 + d8 * 10 + d9, 13) == 0 and mod(d8 * 100 + d9 * 10 + d10, 17) == 0:
                                        allowed[d10] = False
                                        for d5 in range(0, 10):
                                            if allowed[d5]:
                                                allowed[d5] = False
                                                if mod(d5 * 100 + d6 * 10 + d7, 7) == 0:
                                                    for i4 in range(0, 5):
                                                        d4 = i4 * 2
                                                        if allowed[d4]:
                                                            allowed[d4] = False
                                                            for d3 in range(0, 10):
                                                                if allowed[d3]:
                                                                    allowed[d3] = False
                                                                    if mod(d3 + d4 + d5, 3) == 0:
                                                                        for d2 in range(0, 10):
                                                                            if allowed[d2]:
                                                                                allowed[d2] = False
                                                                                for d1 in range(0, 10):
                                                                                    if allowed[d1]:
                                                                                        allowed[d1] = False
                                                                                        print("%d%d%d%d%d%d%d%d%d%d + " % (d1, d2, d3, d4, d5, d6, d7, d8, d9, d10), end='')
                                                                                        allowed[d1] = True
                                                                                allowed[d2] = True
                                                                    allowed[d3] = True
                                                            allowed[d4] = True
                                                allowed[d5] = True
                                        allowed[d10] = True
                                allowed[d9] = True
                        allowed[d8] = True
                allowed[d7] = True
        allowed[d6] = True
print("%d\n" % 0, end='')

