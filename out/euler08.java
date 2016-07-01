import java.util.*;

public class euler08
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int i = 1;
    int[] last = new int[5];
    for (int j = 0; j < 5; j += 1)
    {
        char c = scanner.findWithinHorizon(".", 1).charAt(0);
        int d = (int)(c) - (int)('0');
        i *= d;
        last[j] = d;
    }
    int max0 = i;
    int index = 0;
    int nskipdiv = 0;
    for (int k = 1; k <= 995; k += 1)
    {
        char e = scanner.findWithinHorizon(".", 1).charAt(0);
        int f = (int)(e) - (int)('0');
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
            nskipdiv -= 1;
        }
        last[index] = f;
        index = (index + 1) % 5;
        max0 = Math.max(max0, i);
    }
    System.out.printf("%d\n", max0);
  }
  
}

