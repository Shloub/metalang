import java.util.*;

public class aaa_06readcouple
{
  static Scanner scanner = new Scanner(System.in);
  
  static void main(String[] args)
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
      System.out.printf("a = %s b = %s\n", a, b);
    }
    int[] l = new int[10];
    for (int c = 0 ; c < 10; c++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        l[c] = -scanner.nextInt();
      }else{
        l[c] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    for (int j = 0 ; j <= 9; j ++)
    {
      System.out.printf("%s\n", l[j]);
    }
  }
  
}

