import java.util.*;

public class triangles
{
  static Scanner scanner = new Scanner(System.in);
  /* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
*/
  public static int find0(int len, int[][] tab, int[][] cache, int x, int y)
  {
    /*
	Cette fonction est récursive
	*/
    if (y == (len - 1))
    {
      return tab[y][x];
    }
    else if (x > y)
    {
      return 100000;
    }
    else if (cache[y][x] != 0)
    {
      return cache[y][x];
    }
    int result = 0;
    int out0 = find0(len, tab, cache, x, y + 1);
    int out1 = find0(len, tab, cache, x + 1, y + 1);
    if (out0 < out1)
    {
      result = out0 + tab[y][x];
    }
    else
    {
      result = out1 + tab[y][x];
    }
    cache[y][y] = result;
    return result;
  }
  
  public static int find(int len, int[][] tab)
  {
    int[][] tab2 = new int[len][];
    for (int i = 0 ; i <= len - 1; i ++)
    {
      int bi = i + 1;
      int[] tab3 = new int[bi];
      for (int j = 0 ; j <= bi - 1; j ++)
      {
        tab3[j] = 0;
      }
      tab2[i] = tab3;
    }
    return find0(len, tab, tab2, 0, 0);
  }
  
  
  public static void main(String args[])
  {
    int len = 0;
    scanner.useDelimiter("\\s");
    len = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    int[][] tab = new int[len][];
    for (int i = 0 ; i <= len - 1; i ++)
    {
      int bj = i + 1;
      int[] tab2 = new int[bj];
      for (int j = 0 ; j <= bj - 1; j ++)
      {
        int tmp = 0;
        scanner.useDelimiter("\\s");
        tmp = scanner.nextInt();
        scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
        tab2[j] = tmp;
      }
      tab[i] = tab2;
    }
    int bk = find(len, tab);
    System.out.printf("%d", bk);
    for (int bl = 0 ; bl <= (tab.length) - 1; bl ++)
    {
      int[] bm = tab[bl];
      for (int bn = 0 ; bn <= (bm.length) - 1; bn ++)
      {
        System.out.printf("%d", bm[bn]);
      }
    }
  }
  
}

