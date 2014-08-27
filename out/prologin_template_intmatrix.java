import java.util.*;

public class prologin_template_intmatrix
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
    int f; if (scanner.hasNext("^-")){
    scanner.next("^-"); f = scanner.nextInt();
    } else {
    f = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille_x = f;
    int h; if (scanner.hasNext("^-")){
    scanner.next("^-"); h = scanner.nextInt();
    } else {
    h = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille_y = h;
    int[][] tableau = read_int_matrix(taille_x, taille_y);
    System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

