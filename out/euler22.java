import java.util.*;

public class euler22
{
  static Scanner scanner = new Scanner(System.in);
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
    return sum;
  }
  
  
  public static void main(String args[])
  {
    int sum = 0;
    int n;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      n = scanner.nextInt();
    } else {
      n = scanner.nextInt();
    }
    for (int i = 1; i <= n; i++)
        sum += i * score();
    System.out.printf("%d\n", sum);
  }
  
}

