import java.util.*

int triangle(int n)
{
  if (n % 2 == 0)
      return n.intdiv(2) * (n + 1)
  else
      return n * (n + 1).intdiv(2)
}

int penta(int n)
{
  if (n % 2 == 0)
      return n.intdiv(2) * (3 * n - 1)
  else
      return (3 * n - 1).intdiv(2) * n
}

int hexa(int n)
{
  return n * (2 * n - 1)
}

boolean findPenta2(int n, int a, int b)
{
  if (b == a + 1)
      return penta(a) == n || penta(b) == n
  int c = (a + b).intdiv(2)
  int p = penta(c)
  if (p == n)
      return true
  else if (p < n)
      return findPenta2(n, c, b)
  else
      return findPenta2(n, a, c)
}

boolean findHexa2(int n, int a, int b)
{
  if (b == a + 1)
      return hexa(a) == n || hexa(b) == n
  int c = (a + b).intdiv(2)
  int p = hexa(c)
  if (p == n)
      return true
  else if (p < n)
      return findHexa2(n, c, b)
  else
      return findHexa2(n, a, c)
}


for (int n = 285; n < 55386; n++)
{
    int t = triangle(n)
    if (findPenta2(t, n.intdiv(5), n) && findHexa2(t, n.intdiv(5), n.intdiv(2) + 10))
        System.out.printf("%d\n%d\n", n, t)
}

