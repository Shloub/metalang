import java.util.*;

public class euler11
{
  static Scanner scanner = new Scanner(System.in);
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
    tuple_int_int[] directions = new tuple_int_int[8];
    for (int i = 0 ; i < 8; i++)
      if (i == 0)
    {
      tuple_int_int bh = new tuple_int_int();
      bh.tuple_int_int_field_0 = 0;
      bh.tuple_int_int_field_1 = 1;
      directions[i] = bh;
    }
    else if (i == 1)
    {
      tuple_int_int bg = new tuple_int_int();
      bg.tuple_int_int_field_0 = 1;
      bg.tuple_int_int_field_1 = 0;
      directions[i] = bg;
    }
    else if (i == 2)
    {
      tuple_int_int bf = new tuple_int_int();
      bf.tuple_int_int_field_0 = 0;
      bf.tuple_int_int_field_1 = -1;
      directions[i] = bf;
    }
    else if (i == 3)
    {
      tuple_int_int be = new tuple_int_int();
      be.tuple_int_int_field_0 = -1;
      be.tuple_int_int_field_1 = 0;
      directions[i] = be;
    }
    else if (i == 4)
    {
      tuple_int_int bd = new tuple_int_int();
      bd.tuple_int_int_field_0 = 1;
      bd.tuple_int_int_field_1 = 1;
      directions[i] = bd;
    }
    else if (i == 5)
    {
      tuple_int_int bc = new tuple_int_int();
      bc.tuple_int_int_field_0 = 1;
      bc.tuple_int_int_field_1 = -1;
      directions[i] = bc;
    }
    else if (i == 6)
    {
      tuple_int_int bb = new tuple_int_int();
      bb.tuple_int_int_field_0 = -1;
      bb.tuple_int_int_field_1 = 1;
      directions[i] = bb;
    }
    else
    {
      tuple_int_int ba = new tuple_int_int();
      ba.tuple_int_int_field_0 = -1;
      ba.tuple_int_int_field_1 = -1;
      directions[i] = ba;
    }
    int max0 = 0;
    int h = 20;
    int[][] l = new int[20][];
    for (int o = 0 ; o < 20; o++)
    {
      int[] p = new int[h];
      for (int q = 0 ; q < h; q++)
      {
        int r;
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          r = scanner.nextInt();
        } else {
          r = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
        p[q] = r;
      }
      l[o] = p;
    }
    int[][] m = l;
    for (int j = 0 ; j <= 7; j ++)
    {
      tuple_int_int w = directions[j];
      int dx = w.tuple_int_int_field_0;
      int dy = w.tuple_int_int_field_1;
      for (int x = 0 ; x <= 19; x ++)
        for (int y = 0 ; y <= 19; y ++)
        {
          int v = find(4, m, x, y, dx, dy);
          int u = Math.max(max0, v);
          max0 = u;
      }
    }
    System.out.printf("%d\n", max0);
  }
  
}

