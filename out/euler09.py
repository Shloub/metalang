"""
	a + b + c = 1000 && a * a + b * b = c * c
	"""
for a in range(1, 1 + 1000):
  for b in range(a + 1, 1 + 1000):
    c = 1000 - a - b;
    a2b2 = a * a + b * b;
    cc = c * c;
    if cc == a2b2 and c > a:
      print("%d\n%d\n%d\n%d\n" % ( a, b, c, (a * b * c) ), end='')

