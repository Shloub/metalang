import java.util.*;

public class euler11
{
  static Scanner scanner = new Scanner(System.in);
  public static int max2(int a, int b)
  {
    if (a > b)
      return a;
    return b;
  }
  
  public static int[] read_int_line(int n)
  {
    int[] tab = new int[n];
    for (int i = 0 ; i < n; i++)
    {
      int t = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); t = -scanner.nextInt();
      }else{
      t = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i] = t;
    }
    return tab;
  }
  
  public static int[][] read_int_matrix(int x, int y)
  {
    int[][] tab = new int[y][];
    for (int z = 0 ; z < y; z++)
    {
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[z] = read_int_line(x);
    }
    return tab;
  }
  
  public static int find(int n, int[][] m, int x, int y, int dx, int dy)
  {
    if (x < 0 || x == 20 || y < 0 || y == 20)
      return -1;
    else if (n == 0)
      return 1;
    else
      return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);
  }
  
  static class tuple_int_int {public int tuple_int_int_field_0;public int tuple_int_int_field_1;}
  
  public static void main(String args[])
  {
    int c = 8;
    tuple_int_int[] directions = new tuple_int_int[c];
    for (int i = 0 ; i < c; i++)
      if (i == 0)
    {
      tuple_int_int p = new tuple_int_int();
      p.tuple_int_int_field_0 = 0;
      p.tuple_int_int_field_1 = 1;
      directions[i] = p;
    }
    else if (i == 1)
    {
      tuple_int_int o = new tuple_int_int();
      o.tuple_int_int_field_0 = 1;
      o.tuple_int_int_field_1 = 0;
      directions[i] = o;
    }
    else if (i == 2)
    {
      tuple_int_int l = new tuple_int_int();
      l.tuple_int_int_field_0 = 0;
      l.tuple_int_int_field_1 = -1;
      directions[i] = l;
    }
    else if (i == 3)
    {
      tuple_int_int k = new tuple_int_int();
      k.tuple_int_int_field_0 = -1;
      k.tuple_int_int_field_1 = 0;
      directions[i] = k;
    }
    else if (i == 4)
    {
      tuple_int_int h = new tuple_int_int();
      h.tuple_int_int_field_0 = 1;
      h.tuple_int_int_field_1 = 1;
      directions[i] = h;
    }
    else if (i == 5)
    {
      tuple_int_int g = new tuple_int_int();
      g.tuple_int_int_field_0 = 1;
      g.tuple_int_int_field_1 = -1;
      directions[i] = g;
    }
    else if (i == 6)
    {
      tuple_int_int f = new tuple_int_int();
      f.tuple_int_int_field_0 = -1;
      f.tuple_int_int_field_1 = 1;
      directions[i] = f;
    }
    else
    {
      tuple_int_int e = new tuple_int_int();
      e.tuple_int_int_field_0 = -1;
      e.tuple_int_int_field_1 = -1;
      directions[i] = e;
    }
    int max_ = 0;
    int[][] m = read_int_matrix(20, 20);
    for (int j = 0 ; j <= 7; j ++)
    {
      tuple_int_int d = directions[j];
      int dx = d.tuple_int_int_field_0;
      int dy = d.tuple_int_int_field_1;
      for (int x = 0 ; x <= 19; x ++)
        for (int y = 0 ; y <= 19; y ++)
          max_ = max2(max_, find(4, m, x, y, dx, dy));
    }
    System.out.printf("%d\n", max_);
  }
  
}

