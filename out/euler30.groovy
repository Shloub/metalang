import java.util.*



/*
a + b * 10 + c * 100 + d * 1000 + e * 10 000 =
  a ^ 5 +
  b ^ 5 +
  c ^ 5 +
  d ^ 5 +
  e ^ 5
*/
int[] p = new int[10]
for (int i = 0; i < 10; i++)
  p[i] = i * i * i * i * i
int sum = 0
for (int a = 0; a <= 9; a ++)
  for (int b = 0; b <= 9; b ++)
    for (int c = 0; c <= 9; c ++)
      for (int d = 0; d <= 9; d ++)
        for (int e = 0; e <= 9; e ++)
          for (int f = 0; f <= 9; f ++)
          {
              int s = p[a] + p[b] + p[c] + p[d] + p[e] + p[f]
              int r = a + b * 10 + c * 100 + d * 1000 + e * 10000 + f * 100000
              if (s == r && r != 1)
              {
                  System.out.printf("%s%s%s%s%s%s %s\n", f, e, d, c, b, a, r);
                  sum += r;
              }
}
print(sum)

