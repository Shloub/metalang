using System;

public class calc
{
  /*
La suite de fibonaci
*/
  public static int fibo(int a, int b, int i)
  {
    int out_ = 0;
    int a2 = a;
    int b2 = b;
    for (int j = 0 ; j <= i + 1; j ++)
    {
      Console.Write(j);
      out_ = out_ + a2;
      int tmp = b2;
      b2 = b2 + a2;
      a2 = tmp;
    }
    return out_;
  }
  
  
  public static void Main(String[] args)
  {
    int f = fibo(1, 2, 4);
    Console.Write(f);
  }
  
}

