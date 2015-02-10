import java.util.*;

public class euler24
{
  
  static int fact(int n)
  {
    int prod = 1;
    for (int i = 2 ; i <= n; i ++)
      prod *= i;
    return prod;
  }
  
  static void show(int lim, int nth)
  {
    int[] t = new int[lim];
    for (int i = 0 ; i < lim; i++)
      t[i] = i;
    boolean[] pris = new boolean[lim];
    for (int j = 0 ; j < lim; j++)
      pris[j] = false;
    for (int k = 1 ; k < lim; k++)
    {
      int n = fact(lim - k);
      int nchiffre = nth / n;
      nth %= n;
      for (int l = 0 ; l < lim; l++)
        if (!pris[l])
      {
        if (nchiffre == 0)
        {
          System.out.printf("%d", l);
          pris[l] = true;
        }
        nchiffre --;
      }
    }
    for (int m = 0 ; m < lim; m++)
      if (!pris[m])
      System.out.printf("%d", m);
    System.out.print("\n");
  }
  
  
  public static void main(String args[])
  {
    show(10, 999999);
  }
  
}

