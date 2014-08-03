import java.util.*;

public class aaa_05array
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int b = 5;
    int[] a = new int[b];
    for (int i = 0 ; i < b; i++)
    {
      System.out.printf("%d", i);
      a[i] = i * 2;
    }
  }
  
}

