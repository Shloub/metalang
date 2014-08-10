import java.util.*;

public class aaa_05array
{
  static Scanner scanner = new Scanner(System.in);
  public static boolean[] id(boolean[] b)
  {
    return b;
  }
  
  public static void g(boolean[] t, int index)
  {
    t[index] = false;
  }
  
  
  public static void main(String args[])
  {
    int c = 5;
    boolean[] a = new boolean[c];
    for (int i = 0 ; i < c; i++)
    {
      System.out.printf("%d", i);
      a[i] = (i % 2) == 0;
    }
    boolean d = a[0];
    if (d)
      System.out.print("True");
    else
      System.out.print("False");
    System.out.print("\n");
    g(id(a), 0);
    boolean e = a[0];
    if (e)
      System.out.print("True");
    else
      System.out.print("False");
    System.out.print("\n");
  }
  
}

