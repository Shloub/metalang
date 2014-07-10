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
      int[] b = new int[x];
      for (int c = 0 ; c < x; c++)
      {
        int d = 0;
        if (scanner.hasNext("^-")){
        scanner.next("^-"); d = -scanner.nextInt();
        }else{
        d = scanner.nextInt();}
        scanner.findWithinHorizon("[\n\r ]*", 1);
        b[c] = d;
      }
      int[] a = b;
      tab[z] = a;
    }
    return tab;
  }
  
  
  public static void main(String args[])
  {
    int f = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); f = -scanner.nextInt();
    }else{
    f = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int e = f;
    int len = e;
    System.out.printf("%d=len\n", len);
    int[] h = new int[len];
    for (int k = 0 ; k < len; k++)
    {
      int l = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); l = -scanner.nextInt();
      }else{
      l = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      h[k] = l;
    }
    int[] g = h;
    int[] tab1 = g;
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d=>%d\n", i, tab1[i]);
    }
    int o = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); o = -scanner.nextInt();
    }else{
    o = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int m = o;
    len = m;
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

