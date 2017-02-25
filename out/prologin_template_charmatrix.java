import java.util.*;

public class prologin_template_charmatrix
{
  static Scanner scanner = new Scanner(System.in);
  
  
  
  static int programme_candidat(char[][] tableau, int taille_x, int taille_y)
  {
    int out0 = 0;
    for (int i = 0; i < taille_y; i++)
    {
        for (int j = 0; j < taille_x; j++)
        {
            out0 += (int)(tableau[i][j]) * (i + j * 2);
            System.out.print(tableau[i][j]);
        }
        System.out.print("--\n");
    }
    return out0;
  }
  public static void main(String args[])
  {
    int taille_x = Integer.parseInt(scanner.nextLine());
    int taille_y = Integer.parseInt(scanner.nextLine());
    char[][] a = new char[taille_y][];
    for (int b = 0; b < taille_y; b++)
        a[b] = scanner.nextLine().toCharArray();
    char[][] tableau = a;
    System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

