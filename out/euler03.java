import java.util.*;

public class euler03
{
  
  
  public static void main(String args[])
  {
    int maximum = 1;
    int b0 = 2;
    int a = 408464633;
    int sqrtia = (int)Math.sqrt(a);
    while (a != 1)
    {
      int b = b0;
      boolean found = false;
      while (b <= sqrtia)
      {
        if ((a % b) == 0)
        {
          a /= b;
          b0 = b;
          b = a;
          int e = (int)Math.sqrt(a);
          sqrtia = e;
          found = true;
        }
        b ++;
      }
      if (!found)
      {
        System.out.printf("%d\n", a);
        a = 1;
      }
    }
  }
  
}

