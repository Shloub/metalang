using System;

public class euler34
{
  
  public static void Main(String[] args)
  {
    int[] f = new int[10];
    for (int j = 0; j < 10; j++)
        f[j] = 1;
    for (int i = 1; i < 10; i++)
    {
        f[i] *= i * f[i - 1];
        Console.Write(f[i] + " ");
    }
    int out0 = 0;
    Console.Write("\n");
    for (int a = 0; a < 10; a++)
        for (int b = 0; b < 10; b++)
            for (int c = 0; c < 10; c++)
                for (int d = 0; d < 10; d++)
                    for (int e = 0; e < 10; e++)
                        for (int g = 0; g < 10; g++)
                        {
                            int sum = f[a] + f[b] + f[c] + f[d] + f[e] + f[g];
                            int num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
                            if (a == 0)
                            {
                                sum--;
                                if (b == 0)
                                {
                                    sum--;
                                    if (c == 0)
                                    {
                                        sum--;
                                        if (d == 0)
                                            sum--;
                                    }
                                }
                            }
                            if (sum == num && sum != 1 && sum != 2)
                            {
                                out0 += num;
                                Console.Write(num + " ");
                            }
                        }
    Console.Write("\n" + out0 + "\n");
  }
  
}

