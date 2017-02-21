import java.util.*;

public class euler42
{
  static Scanner scanner = new Scanner(System.in);
  static boolean is_triangular(int n)
  {
    /*
   n = k * (k + 1) / 2
	  n * 2 = k * (k + 1)
   */
    int a = (int)Math.sqrt(n * 2);
    return a * (a + 1) == n * 2;
  }
  
  static int score()
  {
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int len;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      len = scanner.nextInt();
    } else {
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int sum = 0;
    for (int i = 1; i <= len; i++)
    {
        char c = scanner.findWithinHorizon(".", 1).charAt(0);
        sum += (int)(c) - (int)('A') + 1;
        // 		print c print " " print sum print " " 
    }
    if (is_triangular(sum))
        return 1;
    else
        return 0;
  }
  
  
  public static void main(String args[])
  {
    for (int i = 1; i < 56; i++)
        if (is_triangular(i))
            System.out.printf("%d ", i);
    System.out.print("\n");
    int sum = 0;
    int n;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      n = scanner.nextInt();
    } else {
      n = scanner.nextInt();
    }
    for (int i = 1; i <= n; i++)
        sum += score();
    System.out.printf("%d\n", sum);
  }
  
}

