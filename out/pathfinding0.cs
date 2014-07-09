using System;
using System.Collections.Generic;

public class pathfinding0
{
  public static int min2(int a, int b)
  {
    return Math.Min(a, b);
  }
  
  public static int min3(int a, int b, int c)
  {
    return min2(min2(a, b), c);
  }
  
  public static int min4(int a, int b, int c, int d)
  {
    return min3(min2(a, b), c, d);
  }
  
  public static int read_int()
  {
    return int.Parse(Console.ReadLine());
  }
  
  public static char[] read_char_line(int n)
  {
    return Console.ReadLine().ToCharArray();
  }
  
  public static char[][] read_char_matrix(int x, int y)
  {
    char[][] tab = new char[y][];
    for (int z = 0 ; z < y; z++)
      tab[z] = read_char_line(x);
    return tab;
  }
  
  public static int pathfind_aux(int[][] cache, char[][] tab, int x, int y, int posX, int posY)
  {
    if (posX == x - 1 && posY == y - 1)
      return 0;
    else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
      return x * y * 10;
    else if (tab[posY][posX] == (char)35)
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
      {
        Console.Write(tab[i][j]);
        tmp[j] = -1;
      }
      Console.Write("\n");
      cache[i] = tmp;
    }
    return pathfind_aux(cache, tab, x, y, 0, 0);
  }
  
  
  public static void Main(String[] args)
  {
    int x = read_int();
    int y = read_int();
    Console.Write("" + x + " " + y + "\n");
    char[][] tab = read_char_matrix(x, y);
    int result = pathfind(tab, x, y);
    Console.Write(result);
  }
  
}

