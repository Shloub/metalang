import java.util.*;

public class fibo
{
  static Scanner scanner = new Scanner(System.in);
  /*
La suite de fibonaci
*/
  public static int fibo_(int a, int b, int i)
  {
    int out_ = 0;
    int a2 = a;
    int b2 = b;
    for (int j = 0 ; j <= i + 1; j ++)
    {
      out_ = out_ + a2;
      int tmp = b2;
      b2 = b2 + a2;
      a2 = tmp;
    }
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int a = 0;
    int b = 0;
    int i = 0;
    scanner.useDelimiter("\\s");
    a = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    b = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    i = scanner.nextInt();
    int g = fibo_(a, b, i);
    System.out.printf("%d", g);
  }
  
}

