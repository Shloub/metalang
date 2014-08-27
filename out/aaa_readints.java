import java.util.*;

public class aaa_readints
{
  static Scanner scanner = new Scanner(System.in);
  public static int[][] read_int_matrix(int x, int y)
  {
    int[][] tab = new int[y][];
    for (int z = 0 ; z < y; z++)
    {
      int[] b = new int[x];
      for (int c = 0 ; c < x; c++)
      {
        int d; if (scanner.hasNext("^-")){
        scanner.next("^-"); d = scanner.nextInt();
        } else {
        d = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
        b[c] = d;
      }
      tab[z] = b;
    }
    return tab;
  }
  
  
  public static void main(String args[])
  {
    int f; if (scanner.hasNext("^-")){
    scanner.next("^-"); f = scanner.nextInt();
    } else {
    f = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int len = f;
    System.out.printf("%d=len\n", len);
    int[] h = new int[len];
    for (int k = 0 ; k < len; k++)
    {
      if (scanner.hasNext("^-")){
      scanner.next("^-"); h[k] = -scanner.nextInt();
      }else{
      h[k] = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    int[] tab1 = h;
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d=>%d\n", i, tab1[i]);
    }
    if (scanner.hasNext("^-")){
    scanner.next("^-"); len = -scanner.nextInt();
    }else{
    len = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
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

