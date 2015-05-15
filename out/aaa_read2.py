import math
def mod(x, y):
  return x - y * math.trunc(x / y)
"""
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
"""
len = int(input())
print("%d=len\n" % ( len ), end='')
tab = list(map(int, input().split()))
for i in range(0, len):
  print("%d=>%d " % ( i, tab[i] ), end='')
print("")
tab2 = list(map(int, input().split()))
for i_ in range(0, len):
  print("%d==>%d " % ( i_, tab2[i_] ), end='')
strlen = int(input())
print("%d=strlen\n" % ( strlen ), end='')
tab4 = list(input())
for i3 in range(0, strlen):
  tmpc = tab4[i3]
  c = ord(tmpc)
  print("%c:%d " % ( tmpc, c ), end='')
  if tmpc != ' ':
    c = mod(c - ord('a') + 13, 26) + ord('a')
  tab4[i3] = c
for j in range(0, strlen):
  print("%c" % tab4[j], end='')

