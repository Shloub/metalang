import java.util.*;

public class aaa_07triplet
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
      int c;
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        c = scanner.nextInt();
      } else {
        c = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
      System.out.printf("a = %s b = %sc =%s\n", a, b, c);
    }
    int[] l = new int[10];
    for (int d = 0 ; d < 10; d++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        l[d] = -scanner.nextInt();
      }else{
        l[d] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    for (int j = 0 ; j <= 9; j ++)
    {
      System.out.printf("%s\n", l[j]);
    }
  }
  
}

