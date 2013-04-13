import java.util.*;

public class npi
{
  static Scanner scanner = new Scanner(System.in);
  
  public static boolean is_number(char c)
  {
    return (c <= '9') && (c >= '0');
  }
  
  /*
Notation polonaise inversée
*/
  public static int npi_(char[] str, int len)
  {
    int[] stack = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      stack[i] = 0;
    }
    int ptrStack = 0;
    int ptrStr = 0;
    while (ptrStr < len)
    {
      if (str[ptrStr] == ' ')
      {
        ptrStr = ptrStr + 1;
      }
      else if (is_number(str[ptrStr]))
      {
        int num = 0;
        while (str[ptrStr] != ' ')
        {
          num = num * 10 + str[ptrStr] - '0';
          ptrStr = ptrStr + 1;
        }
        stack[ptrStack] = num;
        ptrStack = ptrStack + 1;
      }
      else if (str[ptrStr] == '+')
      {
        stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1];
        ptrStack = ptrStack - 1;
        ptrStr = ptrStr + 1;
      }
    }
    return stack[0];
  }
  
  
  public static void main(String args[])
  {
    int len = 0;
    scanner.useDelimiter("\\s");
    len = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    char[] tab = new char[len];
    for (int i = 0 ; i < len; i++)
    {
      char tmp = '\000';
      tmp = scanner.findWithinHorizon(".", 1).charAt(0);
      tab[i] = tmp;
    }
    int result = npi_(tab, len);
    System.out.printf("%d", result);
  }
  
}

