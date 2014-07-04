import java.util.*;

public class euler08
{
  static Scanner scanner = new Scanner(System.in);
  public static int max2(int a, int b)
  {
    return Math.max(a, b);
  }
  
  
  public static void main(String args[])
  {
    int i = 1;
    int g = 5;
    int[] last = new int[g];
    for (int j = 0 ; j < g; j++)
    {
      char c = '_';
      c = scanner.findWithinHorizon(".", 1).charAt(0);
      int d = c - '0';
      i *= d;
      last[j] = d;
    }
    int max_ = i;
    int index = 0;
    int nskipdiv = 0;
    for (int k = 1 ; k <= 995; k ++)
    {
      char e = '_';
      e = scanner.findWithinHorizon(".", 1).charAt(0);
      int f = e - '0';
      if (f == 0)
      {
        i = 1;
        nskipdiv = 4;
      }
      else
      {
        i *= f;
        if (nskipdiv < 0)
          i /= last[index];
        nskipdiv --;
      }
      last[index] = f;
      index = (index + 1) % 5;
      max_ = max2(max_, i);
    }
    System.out.printf("%d\n", max_);
  }
  
}

