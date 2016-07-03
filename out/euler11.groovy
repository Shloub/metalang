import groovy.transform.Field
import java.util.*

  int[] read_int_line()
  {
    String[] s = scanner.nextLine().split(" ");
    int[] out = new int[s.length];
    for (int i = 0; i < s.length; i++)
      out[i] = Integer.parseInt(s[i]);
    return out;
  }

int find(int n, int[][] m, int x, int y, int dx, int dy)
{
  if (x < 0 || x == 20 || y < 0 || y == 20)
      return -1
  else if (n == 0)
      return 1
  else
      return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy)
}

class Tuple_int_int {
  int tuple_int_int_field_0
  int tuple_int_int_field_1
}

@Field Scanner scanner = new Scanner(System.in)
Tuple_int_int[] directions = new Tuple_int_int[8]
for (int i = 0; i < 8; i += 1)
    if (i == 0)
    {
        Tuple_int_int c = new Tuple_int_int()
        c.tuple_int_int_field_0 = 0
        c.tuple_int_int_field_1 = 1
        directions[i] = c
    }
    else if (i == 1)
    {
        Tuple_int_int d = new Tuple_int_int()
        d.tuple_int_int_field_0 = 1
        d.tuple_int_int_field_1 = 0
        directions[i] = d
    }
    else if (i == 2)
    {
        Tuple_int_int e = new Tuple_int_int()
        e.tuple_int_int_field_0 = 0
        e.tuple_int_int_field_1 = -1
        directions[i] = e
    }
    else if (i == 3)
    {
        Tuple_int_int f = new Tuple_int_int()
        f.tuple_int_int_field_0 = -1
        f.tuple_int_int_field_1 = 0
        directions[i] = f
    }
    else if (i == 4)
    {
        Tuple_int_int g = new Tuple_int_int()
        g.tuple_int_int_field_0 = 1
        g.tuple_int_int_field_1 = 1
        directions[i] = g
    }
    else if (i == 5)
    {
        Tuple_int_int h = new Tuple_int_int()
        h.tuple_int_int_field_0 = 1
        h.tuple_int_int_field_1 = -1
        directions[i] = h
    }
    else if (i == 6)
    {
        Tuple_int_int k = new Tuple_int_int()
        k.tuple_int_int_field_0 = -1
        k.tuple_int_int_field_1 = 1
        directions[i] = k
    }
    else
    {
        Tuple_int_int l = new Tuple_int_int()
        l.tuple_int_int_field_0 = -1
        l.tuple_int_int_field_1 = -1
        directions[i] = l
    }
int max0 = 0
int[][] m = new int[20][]
for (int o = 0; o < 20; o += 1)
    m[o] = read_int_line()
for (int j = 0; j < 8; j += 1)
{
    Tuple_int_int p = directions[j]
    int dx = p.tuple_int_int_field_0
    int dy = p.tuple_int_int_field_1
    for (int x = 0; x < 20; x += 1)
        for (int y = 0; y < 20; y += 1)
            max0 = Math.max(max0, find(4, m, x, y, dx, dy))
}
System.out.printf("%d\n", max0)

