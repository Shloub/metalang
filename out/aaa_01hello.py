import math
print( "Hello World", end='')
a = 5
print("%d \n%dfoo" % ( (4 + 6) * 2, a ), end='')
b = 1 + math.trunc((1 + 1) * 2 * (3 + 8) / 4) - (1 - 2) - 3 == 12 and True
if b:
  print( "True", end='')
else:
  print( "False", end='')
print("")
c = (3 * (4 + 5 + 6) * 2 == 45) == False
if c:
  print( "True", end='')
else:
  print( "False", end='')
print( " ", end='')
d = (2 == 1) == False
if d:
  print( "True", end='')
else:
  print( "False", end='')
print(" %d%d" % ( math.trunc(math.trunc((4 + 1) / 3) / (2 + 1)), math.trunc(math.trunc(4 * 1 / 3) / 2 * 1) ), end='')
e = not (not (a == 0) and not (a == 4))
if e:
  print( "True", end='')
else:
  print( "False", end='')
f = True and not False and not (True and False)
if f:
  print( "True", end='')
else:
  print( "False", end='')
print("")

