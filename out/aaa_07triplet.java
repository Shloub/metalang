import java.util.*;

public class aaa_07triplet
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
      int c;
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        c = scanner.nextInt();
      } else {
        c = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
      System.out.printf("a = %d b = %dc =%d\n", a, b, c);
    }
  }
  
}

