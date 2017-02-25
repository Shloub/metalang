import java.util.*


int[] primesfactors(int n)
{
  int[] tab = new int[n + 1]
  for (int i = 0; i <= n; i++)
      tab[i] = 0
  int d = 2
  while (n != 1 && d * d <= n)
      if (n % d == 0)
      {
          tab[d]++
          n /= d
      }
      else
          d++
  tab[n]++
  return tab
}


int lim = 20
int[] o = new int[lim + 1]
for (int m = 0; m <= lim; m++)
    o[m] = 0
for (int i = 1; i <= lim; i++)
{
    int[] t = primesfactors(i)
    for (int j = 1; j <= i; j++)
        o[j] = Math.max(o[j], t[j])
}
int product = 1
for (int k = 1; k <= lim; k++)
    for (int l = 1; l <= o[k]; l++)
        product *= k
System.out.printf("%d\n", product)

