import java.util.*;

public class plus_petit
{
  static Scanner scanner = new Scanner(System.in);
  public static int go(int[] tab, int a, int b)
  {
    int m = (a + b) / 2;
    if (a == m)
      if (tab[a] == m)
      return b;
    else
      return a;
    int i = a;
    int j = b;
    while (i < j)
    {
      int e = tab[i];
      if (e < m)
        i ++;
      else
      {
        j --;
        tab[i] = tab[j];
        tab[j] = e;
      }
    }
    if (i < m)
      return go(tab, a, m);
    else
      return go(tab, m, b);
  }
  
  public static int plus_petit_(int[] tab, int len)
  {
    return go(tab, 0, len);
  }
  
  
  public static void main(String args[])
  {
    int len = 0;
    scanner.useDelimiter("\\s");
    len = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmp = 0;
      scanner.useDelimiter("\\s");
      tmp = scanner.nextInt();
      scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
      tab[i] = tmp;
    }
    int k = plus_petit_(tab, len);
    System.out.printf("%d", k);
  }
  
}

