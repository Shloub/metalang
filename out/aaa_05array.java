import java.util.*;

public class aaa_05array
{
  
  static boolean[] id(boolean[] b)
  {
    return b;
  }
  static void g(boolean[] t, int index)
  {
    t[index] = false;
  }
  public static void main(String args[])
  {
    int j = 0;
    boolean[] a = new boolean[5];
    for (int i = 0; i < 5; i++)
    {
        System.out.print(i);
        j += i;
        a[i] = i % 2 == 0;
    }
    System.out.printf("%d ", j);
    if (a[0])
        System.out.print("True");
    else
        System.out.print("False");
    System.out.print("\n");
    g(id(a), 0);
    if (a[0])
        System.out.print("True");
    else
        System.out.print("False");
    System.out.print("\n");
  }
  
}

