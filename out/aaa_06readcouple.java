import java.util.*;

public class aaa_06readcouple
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    for (int i = 1 ; i <= 3; i ++)
    {
      int a;
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        a = scanner.nextInt();
      } else {
        a = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
      int b;
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        b = scanner.nextInt();
      } else {
        b = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
      System.out.printf("a = %d b = %d\n", a, b);
    }
  }
  
}

