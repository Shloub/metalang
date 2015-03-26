import java.util.*;

public class euler02
{
  
  
  static void main(String[] args)
  {
    int a = 1;
    int b = 2;
    int sum = 0;
    while (a < 4000000)
    {
      if ((a % 2) == 0)
        sum += a;
      int c = a;
      a = b;
      b += c;
    }
    System.out.printf("%s\n", sum);
  }
  
}

