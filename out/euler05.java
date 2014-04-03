import java.util.*;

public class euler05
{
  static Scanner scanner = new Scanner(System.in);
  public static int max2(int a, int b)
  {
    if (a > b)
      return a;
    return b;
  }
  
  public static int[] primesfactors(int n)
  {
    int c = n + 1;
    int[] tab = new int[c];
    for (int i = 0 ; i < c; i++)
      tab[i] = 0;
    int d = 2;
    while (n != 1 && d * d <= n)
      if ((n % d) == 0)
    {
      tab[d] = tab[d] + 1;
      n /= d;
    }
    else
      d ++;
    tab[n] = tab[n] + 1;
    return tab;
  }
  
  
  public static void main(String args[])
  {
    int lim = 20;
    int e = lim + 1;
    int[] o = new int[e];
    for (int m = 0 ; m < e; m++)
      o[m] = 0;
    for (int i = 1 ; i <= lim; i ++)
    {
      int[] t = primesfactors(i);
      for (int j = 1 ; j <= i; j ++)
        o[j] = max2(o[j], t[j]);
    }
    int product = 1;
    for (int k = 1 ; k <= lim; k ++)
      for (int l = 1 ; l <= o[k]; l ++)
        product *= k;
    System.out.printf("%d%s", product, "\n");
  }
  
}

