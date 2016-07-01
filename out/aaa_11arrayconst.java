import java.util.*;

public class aaa_11arrayconst
{
  
  static void test(int[] tab, int len)
  {
    for (int i = 0; i < len; i += 1)
        System.out.printf("%d ", tab[i]);
    System.out.print("\n");
  }
  
  
  public static void main(String args[])
  {
    int[] t = new int[5];
    for (int i = 0; i < 5; i += 1)
        t[i] = 1;
    test(t, 5);
  }
  
}

