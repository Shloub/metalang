import java.util.*;

public class aaa_11arrayconst
{
  
  static void test(int[] tab, int len)
  {
    for (int i = 0; i < len; i++)
        System.out.printf("%d ", tab[i]);
    System.out.print("\n");
  }
  
  
  public static void main(String args[])
  {
    int[] t = new int[5];
    for (int i = 0; i < 5; i++)
        t[i] = 1;
    test(t, 5);
  }
  
}

