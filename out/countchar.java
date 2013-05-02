import java.util.*;

public class countchar
{
  static Scanner scanner = new Scanner(System.in);
  public static int nth(char[] tab, char tofind, int len)
  {
    int out_ = 0;
    for (int i = 0 ; i < len; i++)
      if (tab[i] == tofind)
      out_ ++;
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int len = 0;
    scanner.useDelimiter("\\s");
    len = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    char tofind = '\000';
    tofind = scanner.findWithinHorizon(".", 1).charAt(0);
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    char[] tab = new char[len];
    for (int i = 0 ; i < len; i++)
    {
      char tmp = '\000';
      tmp = scanner.findWithinHorizon(".", 1).charAt(0);
      tab[i] = tmp;
    }
    int result = nth(tab, tofind, len);
    System.out.printf("%d", result);
  }
  
}

