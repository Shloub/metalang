import java.util.*;

public class pathfinding0
{
  static Scanner scanner = new Scanner(System.in);
  public static int min2(int a, int b)
  {
    return Math.min(a, b);
  }
  
  public static char[][] read_char_matrix(int x, int y)
  {
    char[][] tab = new char[y][];
    for (int z = 0 ; z < y; z++)
    {
      char[] g = scanner.nextLine().toCharArray();
      tab[z] = g;
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
      int k = min2(val1, val2);
      int l = min2(min2(k, val3), val4);
      int h = l;
      int out_ = 1 + h;
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
    int o; if (scanner.hasNext("^-")){
    scanner.next("^-"); o = scanner.nextInt();
    } else {
    o = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int x = o;
    int q; if (scanner.hasNext("^-")){
    scanner.next("^-"); q = scanner.nextInt();
    } else {
    q = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int y = q;
    System.out.printf("%d %d\n", x, y);
    char[][] tab = read_char_matrix(x, y);
    int result = pathfind(tab, x, y);
    System.out.printf("%d", result);
  }
  
}

