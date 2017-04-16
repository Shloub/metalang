import java.util.*;

public class longest_increasing_subsequence
{
  static Scanner scanner = new Scanner(System.in);
  static int[] read_int_line()
  {
    String[] s = scanner.nextLine().split(" ");
    int[] out = new int[s.length];
    for (int i = 0; i < s.length; i++)
      out[i] = Integer.parseInt(s[i]);
    return out;
  }

  static int dichofind(int len, int[] tab, int tofind, int a, int b)
  {
    if (a >= b - 1)
        return a;
    else
    {
        int c = (a + b) / 2;
        if (tab[c] < tofind)
            return dichofind(len, tab, tofind, c, b);
        else
            return dichofind(len, tab, tofind, a, c);
    }
  }
  static int process(int len, int[] tab)
  {
    int[] size = new int[len];
    for (int j = 0; j < len; j++)
        if (j == 0)
            size[j] = 0;
        else
            size[j] = len * 2;
    for (int i = 0; i < len; i++)
    {
        int k = dichofind(len, size, tab[i], 0, len - 1);
        if (size[k + 1] > tab[i])
            size[k + 1] = tab[i];
    }
    for (int l = 0; l < len; l++)
        System.out.printf("%d ", size[l]);
    for (int m = 0; m < len; m++)
    {
        int k = len - 1 - m;
        if (size[k] != len * 2)
            return k;
    }
    return 0;
  }
  public static void main(String args[])
  {
    int n = Integer.parseInt(scanner.nextLine());
    for (int i = 1; i <= n; i++)
    {
        int len = Integer.parseInt(scanner.nextLine());
        System.out.printf("%d\n", process(len, read_int_line()));
    }
  }
  
}

