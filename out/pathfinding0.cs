using System;
using System.Collections.Generic;

public class pathfinding0
{
  static int pathfind_aux(int[][] cache, char[][] tab, int x, int y, int posX, int posY)
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
        int out0 = 1 + Math.Min(Math.Min(Math.Min(val1, val2), val3), val4);
        cache[posY][posX] = out0;
        return out0;
    }
  }
  
  static int pathfind(char[][] tab, int x, int y)
  {
    int[][] cache = new int[y][];
    for (int i = 0; i < y; i++)
    {
        int[] tmp = new int[x];
        for (int j = 0; j < x; j++)
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
    int x = int.Parse(Console.ReadLine());
    int y = int.Parse(Console.ReadLine());
    Console.Write(x + " " + y + "\n");
    char[][] e = new char[y][];
    for (int f = 0; f < y; f++)
        e[f] = Console.ReadLine().ToCharArray();
    char[][] tab = e;
    int result = pathfind(tab, x, y);
    Console.Write(result);
  }
  
}

