import java.util.*;

public class euler40
{
  
  static int exp0(int a, int e)
  {
    int o = 1;
    for (int i = 1; i <= e; i += 1)
        o *= a;
    return o;
  }
  
  static int e(int[] t, int n)
  {
    for (int i = 1; i <= 8; i += 1)
        if (n >= t[i] * i)
            n -= t[i] * i;
        else
        {
            int nombre = exp0(10, i - 1) + n / i;
            int chiffre = i - 1 - n % i;
            return nombre / exp0(10, chiffre) % 10;
        }
    return -1;
  }
  
  
  public static void main(String args[])
  {
    int[] t = new int[9];
    for (int i = 0; i < 9; i += 1)
        t[i] = exp0(10, i) - exp0(10, i - 1);
    for (int i2 = 1; i2 <= 8; i2 += 1)
        System.out.printf("%d => %d\n", i2, t[i2]);
    for (int j = 0; j <= 80; j += 1)
        System.out.print(e(t, j));
    System.out.print("\n");
    for (int k = 1; k <= 50; k += 1)
        System.out.print(k);
    System.out.print("\n");
    for (int j2 = 169; j2 <= 220; j2 += 1)
        System.out.print(e(t, j2));
    System.out.print("\n");
    for (int k2 = 90; k2 <= 110; k2 += 1)
        System.out.print(k2);
    System.out.print("\n");
    int out0 = 1;
    for (int l = 0; l <= 6; l += 1)
    {
        int puiss = exp0(10, l);
        int v = e(t, puiss - 1);
        out0 *= v;
        System.out.printf("10^%d=%d v=%d\n", l, puiss, v);
    }
    System.out.printf("%d\n", out0);
  }
  
}

