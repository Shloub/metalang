import java.util.*;

public class prologin_template_intmatrix
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
  
  public static int programme_candidat(int[][] tableau, int x, int y)
  {
    int out_ = 0;
    for (int i = 0 ; i < y; i++)
      for (int j = 0 ; j < x; j++)
        out_ += tableau[i][j] * (i * 2 + j);
    return out_;
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
    int taille_x = f;
    int k = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); k = -scanner.nextInt();
    }else{
    k = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int h = k;
    int taille_y = h;
    int[][] tableau = read_int_matrix(taille_x, taille_y);
    System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

