import java.util.*;

public class euler02
{
  static Scanner scanner = new Scanner(System.in);
  
  
  public static void main(String args[])
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
    System.out.printf("%d%s", sum, "\n");
  }
  
}

