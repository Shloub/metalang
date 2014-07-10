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
    int f = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); f = -scanner.nextInt();
    }else{
    f = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int e = f;
    int taille_x = e;
    int h = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); h = -scanner.nextInt();
    }else{
    h = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int g = h;
    int taille_y = g;
    int[][] tableau = read_int_matrix(taille_x, taille_y);
    System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}
