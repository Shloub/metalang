import java.util.*;

public class euler15
{
  
  
  public static void main(String args[])
  {
    int n = 10;
    /* normalement on doit mettre 20 mais là on se tape un overflow */
    n += 1;
    int[][] tab = new int[n][];
    for (int i = 0; i < n; i += 1)
    {
        int[] tab2 = new int[n];
        for (int j = 0; j < n; j += 1)
            tab2[j] = 0;
        tab[i] = tab2;
    }
    for (int l = 0; l < n; l += 1)
    {
        tab[n - 1][l] = 1;
        tab[l][n - 1] = 1;
    }
    for (int o = 2; o <= n; o += 1)
    {
        int r = n - o;
        for (int p = 2; p <= n; p += 1)
        {
            int q = n - p;
            tab[r][q] = tab[r + 1][q] + tab[r][q + 1];
        }
    }
    for (int m = 0; m < n; m += 1)
    {
        for (int k = 0; k < n; k += 1)
            System.out.printf("%d ", tab[m][k]);
        System.out.print("\n");
    }
    System.out.printf("%d\n", tab[0][0]);
  }
  
}

