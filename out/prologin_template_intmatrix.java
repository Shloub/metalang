import java.util.*;

public class prologin_template_intmatrix
{
  static Scanner scanner = new Scanner(System.in);
  public static int programme_candidat(int[][] tableau, int x, int y)
  {
    int out0 = 0;
    for (int i = 0 ; i < y; i++)
      for (int j = 0 ; j < x; j++)
        out0 += tableau[i][j] * (i * 2 + j);
    return out0;
  }
  
  
  public static void main(String args[])
  {
    int taille_x;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      taille_x = scanner.nextInt();
    } else {
      taille_x = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille_y;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      taille_y = scanner.nextInt();
    } else {
      taille_y = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int[][] tableau = new int[taille_y][];
    for (int m = 0 ; m < taille_y; m++)
    {
      int[] r = new int[taille_x];
      for (int p = 0 ; p < taille_x; p++)
      {
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          r[p] = -scanner.nextInt();
        }else{
          r[p] = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
      }
      tableau[m] = r;
    }
    System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

