import java.util.*;

public class affect_param
{
  static Scanner scanner = new Scanner(System.in);
  public static void foo(int a)
  {
    a = 4;
  }
  
  
  public static void main(String args[])
  {
    int a = 0;
    foo(a);
    System.out.printf("%d%s", a, "\n");
  }
  
}

