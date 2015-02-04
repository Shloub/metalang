"""
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
"""
p = [None] * 10
for i in range(0, 10):
  p[i] = i * i * i * i * i
sum = 0
for a in range(0, 1 + 9):
  for b in range(0, 1 + 9):
    for c in range(0, 1 + 9):
      for d in range(0, 1 + 9):
        for e in range(0, 1 + 9):
          for f in range(0, 1 + 9):
            s = p[a] + p[b] + p[c] + p[d] + p[e] + p[f]
            r = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000
            if s == r and r != 1:
              print("%d%d%d%d%d%d %d\n" % ( f, e, d, c, b, a, r ), end='')
              sum += r
print("%d" % sum, end='')

