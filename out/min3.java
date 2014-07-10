import java.util.*;

public class min3
{
  static Scanner scanner = new Scanner(System.in);
  public static int min2(int a, int b)
  {
    return Math.min(a, b);
  }
  
  public static int min3_(int a, int b, int c)
  {
    return min2(min2(a, b), c);
  }
  
  
  public static void main(String args[])
  {
    int e = 2;
    int f = 3;
    int g = 4;
    int d = min2(min2(e, f), g);
    System.out.printf("%d ", d);
    int i = 2;
    int j = 4;
    int k = 3;
    int h = min2(min2(i, j), k);
    System.out.printf("%d ", h);
    int m = 3;
    int n = 2;
    int o = 4;
    int l = min2(min2(m, n), o);
    System.out.printf("%d ", l);
    int q = 3;
    int r = 4;
    int s = 2;
    int p = min2(min2(q, r), s);
    System.out.printf("%d ", p);
    int u = 4;
    int v = 2;
    int w = 3;
    int t = min2(min2(u, v), w);
    System.out.printf("%d ", t);
    int y = 4;
    int z = 3;
    int ba = 2;
    int x = min2(min2(y, z), ba);
    System.out.printf("%d\n", x);
  }
  
}

