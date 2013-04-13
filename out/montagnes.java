import java.util.*;

public class montagnes
{
  static Scanner scanner = new Scanner(System.in);
  public static int montagnes_(int[] tab, int len)
  {
    int max_ = 1;
    int j = 1;
    int i = len - 2;
    while (i >= 0)
    {
      int x = tab[i];
      while ((j >= 0) && (x > tab[len - j]))
      {
        j = j - 1;
      }
      j = j + 1;
      tab[len - j] = x;
      if (j > max_)
      {
        max_ = j;
      }
      i = i - 1;
    }
    return max_;
  }
  
  
  public static void main(String args[])
  {
    int len = 0;
    scanner.useDelimiter("\\s");
    len = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    int[] tab = new int[len];
    for (int i = 0 ; i <= len - 1; i ++)
    {
      int x = 0;
      scanner.useDelimiter("\\s");
      x = scanner.nextInt();
      scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
      tab[i] = x;
    }
    int f = montagnes_(tab, len);
    System.out.printf("%d", f);
  }
  
}

