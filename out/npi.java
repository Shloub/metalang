import java.util.*;

public class npi
{
  static Scanner scanner = new Scanner(System.in);
  
  static boolean is_number(char c)
  {
    return (int)(c) <= (int)('9') && (int)(c) >= (int)('0');
  }
  /*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
  static int npi0(char[] str, int len)
  {
    int[] stack = new int[len];
    for (int i = 0; i < len; i++)
        stack[i] = 0;
    int ptrStack = 0;
    int ptrStr = 0;
    while (ptrStr < len)
        if (str[ptrStr] == ' ')
            ptrStr++;
        else if (is_number(str[ptrStr]))
        {
            int num = 0;
            while (str[ptrStr] != ' ')
            {
                num = num * 10 + (int)(str[ptrStr]) - (int)('0');
                ptrStr++;
            }
            stack[ptrStack] = num;
            ptrStack++;
        }
        else if (str[ptrStr] == '+')
        {
            stack[ptrStack - 2] += stack[ptrStack - 1];
            ptrStack--;
            ptrStr++;
        }
    return stack[0];
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
    char[] tab = new char[len];
    for (int i = 0; i < len; i++)
    {
        char tmp = '\u0000';
        tmp = scanner.findWithinHorizon(".", 1).charAt(0);
        tab[i] = tmp;
    }
    int result = npi0(tab, len);
    System.out.print(result);
  }
  
}

