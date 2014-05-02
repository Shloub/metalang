import java.util.*;

public class euler42
{
  static Scanner scanner = new Scanner(System.in);
  
  public static int isqrt(int c)
  {
    return (int)Math.sqrt(c);
  }
  
  
  public static boolean is_triangular(int n)
  {
    /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
    int a = isqrt(n * 2);
    return a * (a + 1) == n * 2;
  }
  
  public static int score()
  {
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int len = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); len = -scanner.nextInt();
    }else{
    len = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int sum = 0;
    for (int i = 1 ; i <= len; i ++)
    {
      char c = '_';
      c = scanner.findWithinHorizon(".", 1).charAt(0);
      sum += (c - 'A') + 1;
      /*		print c print " " print sum print " " */
    }
    if (is_triangular(sum))
      return 1;
    else
      return 0;
  }
  
  
  public static void main(String args[])
  {
    for (int i = 1 ; i <= 55; i ++)
      if (is_triangular(i))
    {
      System.out.printf("%d%s", i, " ");
    }
    System.out.print("\n");
    int sum = 0;
    int n = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); n = -scanner.nextInt();
    }else{
    n = scanner.nextInt();}
    for (int i = 1 ; i <= n; i ++)
      sum += score();
    System.out.printf("%d%s", sum, "\n");
  }
  
}
