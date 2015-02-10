import java.util.*;

public class prologin_template_charmatrix
{
  static Scanner scanner = new Scanner(System.in);
  public static int programme_candidat(char[][] tableau, int taille_x, int taille_y)
  {
    int out0 = 0;
    for (int i = 0 ; i < taille_y; i++)
    {
      for (int j = 0 ; j < taille_x; j++)
      {
        out0 += tableau[i][j] * (i + j * 2);
        System.out.printf("%c", tableau[i][j]);
      }
      System.out.print("--\n");
    }
    return out0;
  }
  
  
  public static void main(String args[])
  {
    int taille_x = Integer.parseInt(scanner.nextLine());
    int taille_y = Integer.parseInt(scanner.nextLine());
    char[][] e = new char[taille_y][];
    for (int f = 0 ; f < taille_y; f++)
      e[f] = scanner.nextLine().toCharArray();
    char[][] tableau = e;
    System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

