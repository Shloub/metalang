import java.util.*;

public class euler07
{
  
  static boolean divisible(int n, int[] t, int size)
  {
    for (int i = 0; i < size; i += 1)
        if (n % t[i] == 0)
            return true;
    return false;
  }
  
  static int find(int n, int[] t, int used, int nth)
  {
    while (used != nth)
        if (divisible(n, t, used))
            n += 1;
        else
        {
            t[used] = n;
            n += 1;
            used += 1;
        }
    return t[used - 1];
  }
  
  
  public static void main(String args[])
  {
    int n = 10001;
    int[] t = new int[n];
    for (int i = 0; i < n; i += 1)
        t[i] = 2;
    System.out.printf("%d\n", find(3, t, 1, n));
  }
  
}

