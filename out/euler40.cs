using System;

public class euler40
{
  static int exp0(int a, int e)
  {
    int o = 1;
    for (int i = 1; i <= e; i++)
        o *= a;
    return o;
  }
  
  static int e(int[] t, int n)
  {
    for (int i = 1; i < 9; i++)
        if (n >= t[i] * i)
            n -= t[i] * i;
        else
        {
            int nombre = exp0(10, i - 1) + n / i;
            int chiffre = i - 1 - n % i;
            return nombre / exp0(10, chiffre) % 10;
        }
    return -1;
  }
  
  public static void Main(String[] args)
  {
    int[] t = new int[9];
    for (int i = 0; i < 9; i++)
        t[i] = exp0(10, i) - exp0(10, i - 1);
    for (int i2 = 1; i2 < 9; i2++)
        Console.Write(i2 + " => " + t[i2] + "\n");
    for (int j = 0; j < 81; j++)
        Console.Write(e(t, j));
    Console.Write("\n");
    for (int k = 1; k < 51; k++)
        Console.Write(k);
    Console.Write("\n");
    for (int j2 = 169; j2 < 221; j2++)
        Console.Write(e(t, j2));
    Console.Write("\n");
    for (int k2 = 90; k2 < 111; k2++)
        Console.Write(k2);
    Console.Write("\n");
    int out0 = 1;
    for (int l = 0; l < 7; l++)
    {
        int puiss = exp0(10, l);
        int v = e(t, puiss - 1);
        out0 *= v;
        Console.Write("10^" + l + "=" + puiss + " v=" + v + "\n");
    }
    Console.Write(out0 + "\n");
  }
  
}

