import java.util.*;

public class euler11
{
  static Scanner scanner = new Scanner(System.in);
  static int find(int n, int[][] m, int x, int y, int dx, int dy)
  {
    if (x < 0 || x == 20 || y < 0 || y == 20)
      return -1;
    else if (n == 0)
      return 1;
    else
      return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);
  }
  
  static class Tuple_int_int {
    int tuple_int_int_field_0;
    int tuple_int_int_field_1;
  }
  
  static void main(String[] args)
  {
    Tuple_int_int[] directions = new Tuple_int_int[8];
    for (int i = 0 ; i < 8; i++)
      if (i == 0)
    {
      Tuple_int_int c = new Tuple_int_int();
      c.tuple_int_int_field_0 = 0;
      c.tuple_int_int_field_1 = 1;
      directions[i] = c;
    }
    else if (i == 1)
    {
      Tuple_int_int d = new Tuple_int_int();
      d.tuple_int_int_field_0 = 1;
      d.tuple_int_int_field_1 = 0;
      directions[i] = d;
    }
    else if (i == 2)
    {
      Tuple_int_int e = new Tuple_int_int();
      e.tuple_int_int_field_0 = 0;
      e.tuple_int_int_field_1 = -1;
      directions[i] = e;
    }
    else if (i == 3)
    {
      Tuple_int_int f = new Tuple_int_int();
      f.tuple_int_int_field_0 = -1;
      f.tuple_int_int_field_1 = 0;
      directions[i] = f;
    }
    else if (i == 4)
    {
      Tuple_int_int g = new Tuple_int_int();
      g.tuple_int_int_field_0 = 1;
      g.tuple_int_int_field_1 = 1;
      directions[i] = g;
    }
    else if (i == 5)
    {
      Tuple_int_int h = new Tuple_int_int();
      h.tuple_int_int_field_0 = 1;
      h.tuple_int_int_field_1 = -1;
      directions[i] = h;
    }
    else if (i == 6)
    {
      Tuple_int_int k = new Tuple_int_int();
      k.tuple_int_int_field_0 = -1;
      k.tuple_int_int_field_1 = 1;
      directions[i] = k;
    }
    else
    {
      Tuple_int_int l = new Tuple_int_int();
      l.tuple_int_int_field_0 = -1;
      l.tuple_int_int_field_1 = -1;
      directions[i] = l;
    }
    int max0 = 0;
    int[][] m = new int[20][];
    for (int o = 0 ; o < 20; o++)
    {
      int[] p = new int[20];
      for (int q = 0 ; q < 20; q++)
      {
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          p[q] = -scanner.nextInt();
        }else{
          p[q] = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
      }
      m[o] = p;
    }
    for (int j = 0 ; j <= 7; j ++)
    {
      Tuple_int_int r = directions[j];
      int dx = r.tuple_int_int_field_0;
      int dy = r.tuple_int_int_field_1;
      for (int x = 0 ; x <= 19; x ++)
        for (int y = 0 ; y <= 19; y ++)
          max0 = Math.max(max0, find(4, m, x, y, dx, dy));
    }
    System.out.printf("%s\n", max0);
  }
  
}

