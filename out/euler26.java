import java.util.*;

public class euler26
{
  static Scanner scanner = new Scanner(System.in);
  public static int periode(int[] restes, int len, int a, int b)
  {
    while (a != 0)
    {
      int chiffre = a / b;
      int reste = a % b;
      for (int i = 0 ; i < len; i++)
        if (restes[i] == reste)
        return len - i;
      restes[len] = reste;
      len ++;
      a = reste * 10;
    }
    return 0;
  }
  
  
  public static void main(String args[])
  {
    int c = 1000;
    int[] t = new int[c];
    for (int j = 0 ; j < c; j++)
      t[j] = 0;
    int m = 0;
    int mi = 0;
    for (int i = 1 ; i <= 1000; i ++)
    {
      int p = periode(t, 0, 1, i);
      if (p > m)
      {
        mi = i;
        m = p;
      }
    }
    System.out.printf("%d\n%d\n", mi, m);
  }
  
}

