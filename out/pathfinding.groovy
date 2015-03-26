import java.util.*;

public class pathfinding
{
  static Scanner scanner = new Scanner(System.in);
  static int pathfind_aux(int[][] cache, char[][] tab, int x, int y, int posX, int posY)
  {
    if (posX == x - 1 && posY == y - 1)
      return 0;
    else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
      return x * y * 10;
    else if (tab[posY][posX] == (char)'#')
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
      int out0 = 1 + Math.min(Math.min(Math.min(val1, val2), val3), val4);
      cache[posY][posX] = out0;
      return out0;
    }
  }
  
  static int pathfind(char[][] tab, int x, int y)
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
  
  
  static void main(String[] args)
  {
    int x = 0;
    int y = 0;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      x = -scanner.nextInt();
    }else{
      x = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      y = -scanner.nextInt();
    }else{
      y = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[][] tab = new char[y][];
    for (int i = 0 ; i < y; i++)
    {
      char[] tab2 = new char[x];
      for (int j = 0 ; j < x; j++)
      {
        char tmp = (char)'\000';
        tmp = scanner.findWithinHorizon(".", 1).charAt(0);
        tab2[j] = tmp;
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i] = tab2;
    }
    int result = pathfind(tab, x, y);
    print(result);
  }
  
}

