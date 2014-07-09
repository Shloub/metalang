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
    System.out.printf("%d %d %d %d %d %d ", isqrt(4), isqrt(16), isqrt(20), isqrt(1000), isqrt(500), isqrt(10));
  }
  
}

