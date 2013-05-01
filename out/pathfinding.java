import java.util.*;

public class pathfinding
{
  static Scanner scanner = new Scanner(System.in);
  public static int min2(int a, int b)
  {
    if (a < b)
      return a;
    return b;
  }
  
  public static int min3(int a, int b, int c)
  {
    return min2(min2(a, b), c);
  }
  
  public static int min4(int a, int b, int c, int d)
  {
    return min3(min2(a, b), c, d);
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
      int out_ = 1 + min4(val1, val2, val3, val4);
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
        tmp[j] = -1;
      cache[i] = tmp;
    }
    return pathfind_aux(cache, tab, x, y, 0, 0);
  }
  
  
  public static void main(String args[])
  {
    int x = 0;
    int y = 0;
    scanner.useDelimiter("\\s");
    x = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    y = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    char[][] tab = new char[y][];
    for (int i = 0 ; i < y; i++)
    {
      char[] tab2 = new char[x];
      for (int j = 0 ; j < x; j++)
      {
        char tmp = '\000';
        tmp = scanner.findWithinHorizon(".", 1).charAt(0);
        tab2[j] = tmp;
      }
      scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
      tab[i] = tab2;
    }
    int result = pathfind(tab, x, y);
    System.out.printf("%d", result);
  }
  
}

