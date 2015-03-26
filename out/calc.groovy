import java.util.*;

public class calc
{
  
  /*
La suite de fibonaci
*/
  static int fibo(int a, int b, int i)
  {
    int out_ = 0;
    int a2 = a;
    int b2 = b;
    for (int j = 0 ; j <= i + 1; j ++)
    {
      print(j);
      out_ += a2;
      int tmp = b2;
      b2 += a2;
      a2 = tmp;
    }
    return out_;
  }
  
  
  static void main(String[] args)
  {
    print(fibo(1, 2, 4));
  }
  
}

