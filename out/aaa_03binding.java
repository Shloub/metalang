import java.util.*;

public class aaa_03binding
{
  
  static int g(int i)
  {
    int j = i * 4;
    if (j % 2 == 1)
      return 0;
    return j;
  }
  
  static void h(int i)
  {
    System.out.printf("%d\n", i);
  }
  
  
  public static void main(String args[])
  {
    h(14);
    int a = 4;
    int b = 5;
    System.out.printf("%d", a + b);
    /* main */
    h(15);
    a = 2;
    b = 1;
    System.out.printf("%d", a + b);
  }
  
}

