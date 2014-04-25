import java.util.*;

public class euler22
{
  static Scanner scanner = new Scanner(System.in);
  
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
    return sum;
  }
  
  
  public static void main(String args[])
  {
    int sum = 0;
    int n = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); n = -scanner.nextInt();
    }else{
    n = scanner.nextInt();}
    for (int i = 1 ; i <= n; i ++)
      sum += i * score();
    System.out.printf("%d%s", sum, "\n");
  }
  
}

