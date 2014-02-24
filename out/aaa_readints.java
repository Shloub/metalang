import java.util.*;

public class aaa_readints
{
  static Scanner scanner = new Scanner(System.in);
  public static int read_int()
  {
    int out_ = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); out_ = -scanner.nextInt();
    }else{
    out_ = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    return out_;
  }
  
  public static int[] read_int_line(int n)
  {
    int[] tab = new int[n];
    for (int i = 0 ; i < n; i++)
    {
      int t = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); t = -scanner.nextInt();
      }else{
      t = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i] = t;
    }
    return tab;
  }
  
  public static int[][] read_int_matrix(int x, int y)
  {
    int[][] tab = new int[y][];
    for (int z = 0 ; z < y; z++)
    {
      int[] out_ = read_int_line(x);
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[z] = out_;
    }
    return tab;
  }
  
  
  public static void main(String args[])
  {
    int len = read_int();
    System.out.printf("%d%s", len, "=len\n");
    int[] tab1 = read_int_line(len);
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d%s", i, "=>");
      int a = tab1[i];
      System.out.printf("%d%s", a, "\n");
    }
    len = read_int();
    int[][] tab2 = read_int_matrix(len, len - 1);
    for (int i = 0 ; i <= len - 2; i ++)
    {
      for (int j = 0 ; j < len; j++)
      {
        int b = tab2[i][j];
        System.out.printf("%d%s", b, " ");
      }
      System.out.print("\n");
    }
  }
  
}

