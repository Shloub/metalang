import math
def mod(x, y):
  return x - y * math.trunc(x / y)
def h( i ):
    """  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end """
    j = i - 2
    while (j <= i + 2):
      if (mod(i, j)) == 5:
        return True
      j += 1
    return False

j = 0
for k in range(0, 1 + 10):
  j += k
  print("%d\n" % ( j ), end='')
i = 4
while (i < 10):
  print("%d" % i, end='')
  i += 1
  j += i
print("%d%dFIN TEST\n" % ( j, i ), end='')

