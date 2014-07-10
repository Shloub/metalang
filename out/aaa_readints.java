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
      int b = x;
      int[] c = new int[b];
      for (int d = 0 ; d < b; d++)
      {
        int e = 0;
        if (scanner.hasNext("^-")){
        scanner.next("^-"); e = -scanner.nextInt();
        }else{
        e = scanner.nextInt();}
        scanner.findWithinHorizon("[\n\r ]*", 1);
        c[d] = e;
      }
      int[] a = c;
      tab[z] = a;
    }
    return tab;
  }
  
  
  public static void main(String args[])
  {
    int g = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); g = -scanner.nextInt();
    }else{
    g = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int f = g;
    int len = f;
    System.out.printf("%d=len\n", len);
    int k = len;
    int[] l = new int[k];
    for (int m = 0 ; m < k; m++)
    {
      int o = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); o = -scanner.nextInt();
      }else{
      o = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      l[m] = o;
    }
    int[] h = l;
    int[] tab1 = h;
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d=>%d\n", i, tab1[i]);
    }
    int q = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); q = -scanner.nextInt();
    }else{
    q = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int p = q;
    len = p;
    int[][] tab2 = read_int_matrix(len, len - 1);
    for (int i = 0 ; i <= len - 2; i ++)
    {
      for (int j = 0 ; j < len; j++)
      {
        System.out.printf("%d ", tab2[i][j]);
      }
      System.out.print("\n");
    }
  }
  
}

