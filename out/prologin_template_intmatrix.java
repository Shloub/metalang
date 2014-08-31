import java.util.*;

public class prologin_template_intmatrix
{
  static Scanner scanner = new Scanner(System.in);
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
    int f;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      f = scanner.nextInt();
    } else {
      f = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille_x = f;
    int h;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      h = scanner.nextInt();
    } else {
      h = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille_y = h;
    int[][] l = new int[taille_y][];
    for (int m = 0 ; m < taille_y; m++)
    {
      int[] o = new int[taille_x];
      for (int p = 0 ; p < taille_x; p++)
      {
        int q;
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          q = scanner.nextInt();
        } else {
          q = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
        o[p] = q;
      }
      l[m] = o;
    }
    int[][] tableau = l;
    System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

