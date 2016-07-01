import java.util.*

int[] primesfactors(int n)
{
  int[] tab = new int[n + 1]
  for (int i = 0; i <= n; i += 1)
      tab[i] = 0
  int d = 2
  while (n != 1 && d * d <= n)
      if (n % d == 0)
      {
          tab[d] += 1
          n /= d
      }
      else
          d += 1
  tab[n] += 1
  return tab
}



int lim = 20
int[] o = new int[lim + 1]
for (int m = 0; m <= lim; m += 1)
    o[m] = 0
for (int i = 1; i <= lim; i += 1)
{
    int[] t = primesfactors(i)
    for (int j = 1; j <= i; j += 1)
        o[j] = Math.max(o[j], t[j])
}
int product = 1
for (int k = 1; k <= lim; k += 1)
    for (int l = 1; l <= o[k]; l += 1)
        product *= k
System.out.printf("%d\n", product)

