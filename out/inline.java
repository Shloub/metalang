import java.util.*;

public class inline
{
  static Scanner scanner = new Scanner(System.in);
  public static void foo(int i)
  {
    System.out.printf("%d\n", i);
  }
  
  public static void foobar(int i)
  {
    System.out.printf("%d\nfoobar", i);
  }
  
  
  public static void main(String args[])
  {
    int a = 0;
    System.out.printf("%d\n", a);
    int b = 12;
    System.out.printf("%d\nfoobar", b);
    int c = 1;
    System.out.printf("%d\n", c);
  }
  
}

