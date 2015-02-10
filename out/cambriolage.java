import java.util.*;

public class cambriolage
{
  static Scanner scanner = new Scanner(System.in);
  static int nbPassePartout(int n, int[][] passepartout, int m, int[][] serrures)
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
      max_ancient_pp = Math.max(max_ancient_pp, pp[0]);
      max_recent_pp = Math.max(max_recent_pp, pp[1]);
    }
    if (max_ancient_pp >= max_ancient && max_recent_pp >= max_recent)
      return 2;
    else
      return 0;
  }
  
  
  public static void main(String args[])
  {
    int n;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      n = scanner.nextInt();
    } else {
      n = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[][] passepartout = new int[n][];
    for (int i = 0 ; i < n; i++)
    {
      int[] out0 = new int[2];
      for (int j = 0 ; j < 2; j++)
      {
        int out01;
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          out01 = scanner.nextInt();
        } else {
          out01 = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
        out0[j] = out01;
      }
      passepartout[i] = out0;
    }
    int m;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      m = scanner.nextInt();
    } else {
      m = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[][] serrures = new int[m][];
    for (int k = 0 ; k < m; k++)
    {
      int[] out1 = new int[2];
      for (int l = 0 ; l < 2; l++)
      {
        int out_;
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          out_ = scanner.nextInt();
        } else {
          out_ = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
        out1[l] = out_;
      }
      serrures[k] = out1;
    }
    System.out.printf("%d", nbPassePartout(n, passepartout, m, serrures));
  }
  
}

