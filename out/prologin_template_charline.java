import java.util.*;

public class prologin_template_charline
{
  static Scanner scanner = new Scanner(System.in);
  
  
  
  static int programme_candidat(char[] tableau, int taille)
  {
    int out0 = 0;
    for (int i = 0; i < taille; i++)
    {
        out0 += (int)(tableau[i]) * i;
        System.out.print(tableau[i]);
    }
    System.out.print("--\n");
    return out0;
  }
  public static void main(String args[])
  {
    int taille = Integer.parseInt(scanner.nextLine());
    char[] tableau = scanner.nextLine().toCharArray();
    System.out.printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

