import java.util.*;

public class cambriolage
{
  static Scanner scanner = new Scanner(System.in);
  public static int max2(int a, int b)
  {
    if (a > b)
      return a;
    return b;
  }
  
  public static int nbPassePartout(int n, int[][] passepartout, int m, int[][] serrures)
  {
    int max_ancient = 0;
    int max_recent = 0;
    for (int i = 0 ; i < m; i++)
    {
      if (serrures[i][0] == -1 && serrures[i][1] > max_ancient)
        max_ancient = serrures[i][1];
      if (serrures[i][0] == 1 && serrures[i][1] > max_recent)
        max_recent = serrures[i][1];
    }
    int max_ancient_pp = 0;
    int max_recent_pp = 0;
    for (int i = 0 ; i < n; i++)
    {
      int[] pp = passepartout[i];
      if (pp[0] >= max_ancient && pp[1] >= max_recent)
        return 1;
      max_ancient_pp = max2(max_ancient_pp, pp[0]);
      max_recent_pp = max2(max_recent_pp, pp[1]);
    }
    if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
      return 2;
    else
      return 0;
  }
  
  
  public static void main(String args[])
  {
    int n = 0;
    scanner.useDelimiter("\\s");
    n = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    int[][] passepartout = new int[n][];
    for (int i = 0 ; i < n; i++)
    {
      int u = 2;
      int[] out0 = new int[u];
      for (int j = 0 ; j < u; j++)
      {
        int out_ = 0;
        scanner.useDelimiter("\\s");
        out_ = scanner.nextInt();
        scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
        out0[j] = out_;
      }
      passepartout[i] = out0;
    }
    int m = 0;
    scanner.useDelimiter("\\s");
    m = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    int[][] serrures = new int[m][];
    for (int i = 0 ; i < m; i++)
    {
      int v = 2;
      int[] out0 = new int[v];
      for (int j = 0 ; j < v; j++)
      {
        int out_ = 0;
        scanner.useDelimiter("\\s");
        out_ = scanner.nextInt();
        scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
        out0[j] = out_;
      }
      serrures[i] = out0;
    }
    int w = nbPassePartout(n, passepartout, m, serrures);
    System.out.printf("%d", w);
  }
  
}

