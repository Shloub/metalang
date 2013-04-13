import java.util.*;

public class devine
{
  static Scanner scanner = new Scanner(System.in);
  public static boolean devine_(int nombre, int[] tab, int len)
  {
    int min_ = tab[0];
    int max_ = tab[1];
    for (int i = 2 ; i <= len - 1; i ++)
    {
      if ((tab[i] > max_) || (tab[i] < min_))
      {
        return false;
      }
      if (tab[i] < nombre)
      {
        min_ = tab[i];
      }
      if (tab[i] > nombre)
      {
        max_ = tab[i];
      }
      if ((tab[i] == nombre) && (len != (i + 1)))
      {
        return false;
      }
    }
    return true;
  }
  
  
  public static void main(String args[])
  {
    int nombre = 0;
    scanner.useDelimiter("\\s");
    nombre = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    int len = 0;
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
    boolean f = devine_(nombre, tab, len);
    if (f)
    {
      System.out.printf("%s", "True");
    }
    else
    {
      System.out.printf("%s", "False");
    }
  }
  
}

