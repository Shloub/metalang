import math
def eratostene( t, max_ ):
    sum = 0;
    for i in range(2, max_):
      if t[i] == i:
        sum += i
        j = i * i;
        """
			detect overflow
			"""
        if math.trunc(j / i) == i:
          while (j < max_ and j > 0):
            t[j] = 0;
            j += i
    return sum;

n = 100000;
""" normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages """
t = [None] * n
for i in range(0, n):
  t[i] = i;
t[1] = 0;
a = eratostene(t, n);
print("%d\n" % ( a ), end='')

