import java.util.*;

public class euler34
{
  
  
  public static void main(String args[])
  {
    int[] f = new int[10];
    for (int j = 0 ; j < 10; j++)
      f[j] = 1;
    for (int i = 1 ; i <= 9; i ++)
    {
      f[i] = f[i] * i * f[i - 1];
      System.out.printf("%d ", f[i]);
    }
    int out0 = 0;
    System.out.print("\n");
    for (int a = 0 ; a <= 9; a ++)
      for (int b = 0 ; b <= 9; b ++)
        for (int c = 0 ; c <= 9; c ++)
          for (int d = 0 ; d <= 9; d ++)
            for (int e = 0 ; e <= 9; e ++)
              for (int g = 0 ; g <= 9; g ++)
              {
                int sum = f[a] + f[b] + f[c] + f[d] + f[e] + f[g];
                int num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
                if (a == 0)
                {
                  sum --;
                  if (b == 0)
                  {
                    sum --;
                    if (c == 0)
                    {
                      sum --;
                      if (d == 0)
                        sum --;
                    }
                  }
                }
                if (sum == num && sum != 1 && sum != 2)
                {
                  out0 += num;
                  System.out.printf("%d ", num);
                }
    }
    System.out.printf("\n%d\n", out0);
  }
  
}

