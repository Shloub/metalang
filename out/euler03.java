import java.util.*;

public class euler03
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int maximum = 1;
    int b0 = 2;
    int a = 408464633;
    while (a != 1)
    {
      int b = b0;
      boolean found = false;
      while (b * b < a)
      {
        if ((a % b) == 0)
        {
          a /= b;
          b0 = b;
          b = a;
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

