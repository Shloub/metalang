using System;

public class euler26
{
  static int periode(int[] restes, int len, int a, int b)
  {
    while (a != 0)
    {
        int chiffre = a / b;
        int reste = a % b;
        for (int i = 0; i < len; i += 1)
            if (restes[i] == reste)
                return len - i;
        restes[len] = reste;
        len += 1;
        a = reste * 10;
    }
    return 0;
  }
  
  
  public static void Main(String[] args)
  {
    int[] t = new int[1000];
    for (int j = 0; j < 1000; j += 1)
        t[j] = 0;
    int m = 0;
    int mi = 0;
    for (int i = 1; i <= 1000; i += 1)
    {
        int p = periode(t, 0, 1, i);
        if (p > m)
        {
            mi = i;
            m = p;
        }
    }
    Console.Write(mi + "\n" + m + "\n");
  }
  
}

