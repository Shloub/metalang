import java.util.*;

public class sqrttest
{
  static Scanner scanner = new Scanner(System.in);
  
  public static int isqrt(int c)
  {
    return (int)Math.sqrt(c);
  }
  
  
  public static void main(String args[])
  {
    int a = isqrt(4);
    System.out.printf("%d%s", a, " ");
    int b = isqrt(16);
    System.out.printf("%d%s", b, " ");
    int d = isqrt(20);
    System.out.printf("%d%s", d, " ");
    int e = isqrt(1000);
    System.out.printf("%d%s", e, " ");
    int f = isqrt(500);
    System.out.printf("%d%s", f, " ");
    int g = isqrt(10);
    System.out.printf("%d%s", g, " ");
  }
  
}

