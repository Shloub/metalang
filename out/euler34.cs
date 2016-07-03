using System;

public class euler34
{
  
  public static void Main(String[] args)
  {
    int[] f = new int[10];
    for (int j = 0; j < 10; j += 1)
        f[j] = 1;
    for (int i = 1; i < 10; i += 1)
    {
        f[i] *= i * f[i - 1];
        Console.Write(f[i] + " ");
    }
    int out0 = 0;
    Console.Write("\n");
    for (int a = 0; a < 10; a += 1)
        for (int b = 0; b < 10; b += 1)
            for (int c = 0; c < 10; c += 1)
                for (int d = 0; d < 10; d += 1)
                    for (int e = 0; e < 10; e += 1)
                        for (int g = 0; g < 10; g += 1)
                        {
                            int sum = f[a] + f[b] + f[c] + f[d] + f[e] + f[g];
                            int num = ((((a * 10 + b) * 10 + c) * 10 + d) * 10 + e) * 10 + g;
                            if (a == 0)
                            {
                                sum -= 1;
                                if (b == 0)
                                {
                                    sum -= 1;
                                    if (c == 0)
                                    {
                                        sum -= 1;
                                        if (d == 0)
                                            sum -= 1;
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

