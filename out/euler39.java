import java.util.*;

public class euler39
{
  
  
  public static void main(String args[])
  {
    int[] t = new int[1001];
    for (int i = 0; i < 1001; i++)
      t[i] = 0;
    for (int a = 1; a <= 1000; a ++)
      for (int b = 1; b <= 1000; b ++)
      {
          int c2 = a * a + b * b;
          int c = (int)Math.sqrt(c2);
          if (c * c == c2)
          {
              int p = a + b + c;
              if (p <= 1000)
                t[p]++;
          }
    }
    int j = 0;
    for (int k = 1; k <= 1000; k ++)
      if (t[k] > t[j])
      j = k;
    System.out.printf("%d", j);
  }
  
}

