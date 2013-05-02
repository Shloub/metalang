import java.util.*;

public class summax_souslist
{
  static Scanner scanner = new Scanner(System.in);
  public static int summax(int[] lst, int len)
  {
    int current = 0;
    int max_ = 0;
    for (int i = 0 ; i < len; i++)
    {
      current += lst[i];
      if (current < 0)
        current = 0;
      if (max_ < current)
        max_ = current;
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
    for (int i = 0 ; i < len; i++)
    {
      int tmp = 0;
      scanner.useDelimiter("\\s");
      tmp = scanner.nextInt();
      scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
      tab[i] = tmp;
    }
    int result = summax(tab, len);
    System.out.printf("%d", result);
  }
  
}

