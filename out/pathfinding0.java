import java.util.*;

public class pathfinding0
{
  static Scanner scanner = new Scanner(System.in);
  public static int min2(int a, int b)
  {
    return Math.min(a, b);
  }
  
  public static int min3(int a, int b, int c)
  {
    return min2(min2(a, b), c);
  }
  
  public static int min4(int a, int b, int c, int d)
  {
    int f = min2(a, b);
    int g = c;
    int h = d;
    int e = min2(min2(f, g), h);
    return e;
  }
  
  public static int read_int()
  {
    int out_ = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); out_ = -scanner.nextInt();
    }else{
    out_ = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    return out_;
  }
  
  public static char[] read_char_line(int n)
  {
    return scanner.nextLine().toCharArray();
  }
  
  public static char[][] read_char_matrix(int x, int y)
  {
    char[][] tab = new char[y][];
    for (int z = 0 ; z < y; z++)
    {
      int l = x;
      char[] k = scanner.nextLine().toCharArray();
      tab[z] = k;
    }
    return tab;
  }
  
  public static int pathfind_aux(int[][] cache, char[][] tab, int x, int y, int posX, int posY)
  {
    if (posX == x - 1 && posY == y - 1)
      return 0;
    else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
      return x * y * 10;
    else if (tab[posY][posX] == '#')
      return x * y * 10;
    else if (cache[posY][posX] != -1)
      return cache[posY][posX];
    else
    {
      cache[posY][posX] = x * y * 10;
      int val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
      int val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
      int val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
      int val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
      int o = val1;
      int p = val2;
      int q = val3;
      int r = val4;
      int s = min2(o, p);
      int t = q;
      int u = r;
      int v = min2(min2(s, t), u);
      int m = v;
      int out_ = 1 + m;
      cache[posY][posX] = out_;
      return out_;
    }
  }
  
  public static int pathfind(char[][] tab, int x, int y)
  {
    int[][] cache = new int[y][];
    for (int i = 0 ; i < y; i++)
    {
      int[] tmp = new int[x];
      for (int j = 0 ; j < x; j++)
      {
        System.out.printf("%c", tab[i][j]);
        tmp[j] = -1;
      }
      System.out.print("\n");
      cache[i] = tmp;
    }
    return pathfind_aux(cache, tab, x, y, 0, 0);
  }
  
  
  public static void main(String args[])
  {
    int ba = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); ba = -scanner.nextInt();
    }else{
    ba = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int w = ba;
    int x = w;
    int bc = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); bc = -scanner.nextInt();
    }else{
    bc = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int bb = bc;
    int y = bb;
    System.out.printf("%d %d\n", x, y);
    char[][] tab = read_char_matrix(x, y);
    int result = pathfind(tab, x, y);
    System.out.printf("%d", result);
  }
  
}

