import java.util.*;

public class prologin_template_intmatrix
{
  static Scanner scanner = new Scanner(System.in);
  static int programme_candidat(int[][] tableau, int x, int y)
  {
    int out0 = 0;
    for (int i = 0 ; i < y; i++)
      for (int j = 0 ; j < x; j++)
        out0 += tableau[i][j] * (i * 2 + j);
    return out0;
  }
  
  
  static void main(String[] args)
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
    for (int a = 0 ; a < taille_y; a++)
    {
      int[] b = new int[taille_x];
      for (int c = 0 ; c < taille_x; c++)
      {
        if (scanner.hasNext("^-")){
          scanner.next("^-");
          b[c] = -scanner.nextInt();
        }else{
          b[c] = scanner.nextInt();
        }
        scanner.findWithinHorizon("[\n\r ]*", 1);
      }
      tableau[a] = b;
    }
    System.out.printf("%s\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

