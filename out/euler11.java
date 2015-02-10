import java.util.*;

public class euler11
{
  static Scanner scanner = new Scanner(System.in);
    static int[] read_int_line(){
        String s[] = scanner.nextLine().split(" ");
        int out[] = new int[s.length];
        for (int i = 0; i < s.length; i ++)
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
  
  static class tuple_int_int {public int tuple_int_int_field_0;public int tuple_int_int_field_1;}
  
  public static void main(String args[])
  {
    tuple_int_int[] directions = new tuple_int_int[8];
    for (int i = 0 ; i < 8; i++)
      if (i == 0)
    {
      tuple_int_int ba = new tuple_int_int();
      ba.tuple_int_int_field_0 = 0;
      ba.tuple_int_int_field_1 = 1;
      directions[i] = ba;
    }
    else if (i == 1)
    {
      tuple_int_int w = new tuple_int_int();
      w.tuple_int_int_field_0 = 1;
      w.tuple_int_int_field_1 = 0;
      directions[i] = w;
    }
    else if (i == 2)
    {
      tuple_int_int v = new tuple_int_int();
      v.tuple_int_int_field_0 = 0;
      v.tuple_int_int_field_1 = -1;
      directions[i] = v;
    }
    else if (i == 3)
    {
      tuple_int_int u = new tuple_int_int();
      u.tuple_int_int_field_0 = -1;
      u.tuple_int_int_field_1 = 0;
      directions[i] = u;
    }
    else if (i == 4)
    {
      tuple_int_int t = new tuple_int_int();
      t.tuple_int_int_field_0 = 1;
      t.tuple_int_int_field_1 = 1;
      directions[i] = t;
    }
    else if (i == 5)
    {
      tuple_int_int s = new tuple_int_int();
      s.tuple_int_int_field_0 = 1;
      s.tuple_int_int_field_1 = -1;
      directions[i] = s;
    }
    else if (i == 6)
    {
      tuple_int_int r = new tuple_int_int();
      r.tuple_int_int_field_0 = -1;
      r.tuple_int_int_field_1 = 1;
      directions[i] = r;
    }
    else
    {
      tuple_int_int q = new tuple_int_int();
      q.tuple_int_int_field_0 = -1;
      q.tuple_int_int_field_1 = -1;
      directions[i] = q;
    }
    int max0 = 0;
    int[][] m = new int[20][];
    for (int h = 0 ; h < 20; h++)
      m[h] = read_int_line();
    for (int j = 0 ; j <= 7; j ++)
    {
      tuple_int_int p = directions[j];
      int dx = p.tuple_int_int_field_0;
      int dy = p.tuple_int_int_field_1;
      for (int x = 0 ; x <= 19; x ++)
        for (int y = 0 ; y <= 19; y ++)
          max0 = Math.max(max0, find(4, m, x, y, dx, dy));
    }
    System.out.printf("%d\n", max0);
  }
  
}

