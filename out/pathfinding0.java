import java.util.*;

public class pathfinding0
{
  static Scanner scanner = new Scanner(System.in);
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
      int p = Math.min(val1, val2);
      int q = Math.min(p, val3);
      int r = Math.min(q, val4);
      int s = r;
      int o = s;
      int out_ = 1 + o;
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
    int u;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      u = scanner.nextInt();
    } else {
      u = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int x = u;
    int w;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      w = scanner.nextInt();
    } else {
      w = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int y = w;
    System.out.printf("%d %d\n", x, y);
    char[][] bb = new char[y][];
    for (int bc = 0 ; bc < y; bc++)
      bb[bc] = scanner.nextLine().toCharArray();
    char[][] tab = bb;
    int result = pathfind(tab, x, y);
    System.out.printf("%d", result);
  }
  
}

