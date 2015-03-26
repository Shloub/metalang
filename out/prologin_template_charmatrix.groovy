import java.util.*;

public class prologin_template_charmatrix
{
  static Scanner scanner = new Scanner(System.in);
  static int programme_candidat(char[][] tableau, int taille_x, int taille_y)
  {
    int out0 = 0;
    for (int i = 0 ; i < taille_y; i++)
    {
      for (int j = 0 ; j < taille_x; j++)
      {
        out0 += tableau[i][j] * (i + j * 2);
        print(tableau[i][j]);
      }
      print("--\n");
    }
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
    char[][] a = new char[taille_y][];
    for (int b = 0 ; b < taille_y; b++)
    {
      char[] c = new char[taille_x];
      for (int d = 0 ; d < taille_x; d++)
        c[d] = scanner.findWithinHorizon(".", 1).charAt(0);
      scanner.findWithinHorizon("[\n\r ]*", 1);
      a[b] = c;
    }
    char[][] tableau = a;
    System.out.printf("%s\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

