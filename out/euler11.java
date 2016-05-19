import java.util.*;

public class euler11
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

  static int find(int n, int[][] m, int x, int y, int dx, int dy)
  {
    if (x < 0 || x == 20 || y < 0 || y == 20)
      return -1;
    else if (n == 0)
      return 1;
    else
      return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);
  }
  
  static class tuple_int_int {
    public int tuple_int_int_field_0;
    public int tuple_int_int_field_1;
  }
  
  public static void main(String args[])
  {
    tuple_int_int[] directions = new tuple_int_int[8];
    for (int i = 0; i < 8; i++)
      if (i == 0)
    {
        tuple_int_int c = new tuple_int_int();
        c.tuple_int_int_field_0 = 0;
        c.tuple_int_int_field_1 = 1;
        directions[i] = c;
    }
    else if (i == 1)
    {
        tuple_int_int d = new tuple_int_int();
        d.tuple_int_int_field_0 = 1;
        d.tuple_int_int_field_1 = 0;
        directions[i] = d;
    }
    else if (i == 2)
    {
        tuple_int_int e = new tuple_int_int();
        e.tuple_int_int_field_0 = 0;
        e.tuple_int_int_field_1 = -1;
        directions[i] = e;
    }
    else if (i == 3)
    {
        tuple_int_int f = new tuple_int_int();
        f.tuple_int_int_field_0 = -1;
        f.tuple_int_int_field_1 = 0;
        directions[i] = f;
    }
    else if (i == 4)
    {
        tuple_int_int g = new tuple_int_int();
        g.tuple_int_int_field_0 = 1;
        g.tuple_int_int_field_1 = 1;
        directions[i] = g;
    }
    else if (i == 5)
    {
        tuple_int_int h = new tuple_int_int();
        h.tuple_int_int_field_0 = 1;
        h.tuple_int_int_field_1 = -1;
        directions[i] = h;
    }
    else if (i == 6)
    {
        tuple_int_int k = new tuple_int_int();
        k.tuple_int_int_field_0 = -1;
        k.tuple_int_int_field_1 = 1;
        directions[i] = k;
    }
    else
    {
        tuple_int_int l = new tuple_int_int();
        l.tuple_int_int_field_0 = -1;
        l.tuple_int_int_field_1 = -1;
        directions[i] = l;
    }
    int max0 = 0;
    int[][] m = new int[20][];
    for (int o = 0; o < 20; o++)
      m[o] = read_int_line();
    for (int j = 0; j <= 7; j ++)
    {
        tuple_int_int p = directions[j];
        int dx = p.tuple_int_int_field_0;
        int dy = p.tuple_int_int_field_1;
        for (int x = 0; x <= 19; x ++)
          for (int y = 0; y <= 19; y ++)
            max0 = Math.max(max0, find(4, m, x, y, dx, dy));
    }
    System.out.printf("%d\n", max0);
  }
  
}

