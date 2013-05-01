import java.util.*;

public class dichoexp
{
  static Scanner scanner = new Scanner(System.in);
  public static int exp_(int a, int b)
  {
    if (b == 0)
      return 1;
    if ((b % 2) == 0)
    {
      int o = exp_(a, b / 2);
      return o * o;
    }
    else
      return a * exp_(a, b - 1);
  }
  
  
  public static void main(String args[])
  {
    int a = 0;
    int b = 0;
    scanner.useDelimiter("\\s");
    a = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    b = scanner.nextInt();
    int g = exp_(a, b);
    System.out.printf("%d", g);
  }
  
}

