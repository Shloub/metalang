import java.util.*;

public class aaa_06readcouple
{
  static Scanner scanner = new Scanner(System.in);
  static class tuple_int_int {public int tuple_int_int_field_0;public int tuple_int_int_field_1;}
  
  public static void main(String args[])
  {
    for (int i = 1 ; i <= 3; i ++)
    {
      int d;
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        d = scanner.nextInt();
      } else {
        d = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
      int e;
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        e = scanner.nextInt();
      } else {
        e = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tuple_int_int f = new tuple_int_int();
      f.tuple_int_int_field_0 = d;
      f.tuple_int_int_field_1 = e;
      int a = f.tuple_int_int_field_0;
      int b = f.tuple_int_int_field_1;
      System.out.printf("a = %d b = %d\n", a, b);
    }
  }
  
}

