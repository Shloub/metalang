import java.util.*;

public class countchar
{
  static Scanner scanner = new Scanner(System.in);
  static int nth(char[] tab, char tofind, int len)
  {
    int out0 = 0;
    for (int i = 0; i < len; i++)
        if (tab[i] == tofind)
            out0++;
    return out0;
  }
  public static void main(String args[])
  {
    int len = 0;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      len = -scanner.nextInt();
    }else{
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char tofind = '\u0000';
    tofind = scanner.findWithinHorizon(".", 1).charAt(0);
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[] tab = new char[len];
    for (int i = 0; i < len; i++)
    {
        char tmp = '\u0000';
        tmp = scanner.findWithinHorizon(".", 1).charAt(0);
        tab[i] = tmp;
    }
    int result = nth(tab, tofind, len);
    System.out.print(result);
  }
  
}

