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
    if (scanner.hasNext("^-")){
    scanner.next("^-"); n = -scanner.nextInt();
    }else{
    n = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[][] passepartout = new int[n][];
    for (int i = 0 ; i < n; i++)
    {
      int c = 2;
      int[] out0 = new int[c];
      for (int j = 0 ; j < c; j++)
      {
        int out__ = 0;
        if (scanner.hasNext("^-")){
        scanner.next("^-"); out__ = -scanner.nextInt();
        }else{
        out__ = scanner.nextInt();}
        scanner.findWithinHorizon("[\n\r ]*", 1);
        out0[j] = out__;
      }
      passepartout[i] = out0;
    }
    int m = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); m = -scanner.nextInt();
    }else{
    m = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[][] serrures = new int[m][];
    for (int k = 0 ; k < m; k++)
    {
      int d = 2;
      int[] out1 = new int[d];
      for (int l = 0 ; l < d; l++)
      {
        int out_ = 0;
        if (scanner.hasNext("^-")){
        scanner.next("^-"); out_ = -scanner.nextInt();
        }else{
        out_ = scanner.nextInt();}
        scanner.findWithinHorizon("[\n\r ]*", 1);
        out1[l] = out_;
      }
      serrures[k] = out1;
    }
    int e = nbPassePartout(n, passepartout, m, serrures);
    System.out.printf("%d", e);
  }
  
}

