import java.util.*;

public class sort
{
  static Scanner scanner = new Scanner(System.in);
  public static void sort_(int[] tab, int len)
  {
    for (int i = 0 ; i <= len - 1; i ++)
    {
      for (int j = i + 1 ; j <= len - 1; j ++)
      {
        if (tab[i] > tab[j])
        {
          int tmp = tab[i];
          tab[i] = tab[j];
          tab[j] = tmp;
        }
      }
    }
  }
  
  
  public static void main(String args[])
  {
    int len = 2;
    scanner.useDelimiter("\\s");
    len = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    int[] tab = new int[len];
    for (int i = 0 ; i <= len - 1; i ++)
    {
      int tmp = 0;
      scanner.useDelimiter("\\s");
      tmp = scanner.nextInt();
      scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
      tab[i] = tmp;
    }
    sort_(tab, len);
    for (int l = 0 ; l <= (tab.length) - 1; l ++)
    {
      System.out.printf("%d", tab[l]);
    }
  }
  
}

