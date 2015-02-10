import java.util.*;

public class prologin_template_2charline
{
  static Scanner scanner = new Scanner(System.in);
  static int programme_candidat(char[] tableau1, int taille1, char[] tableau2, int taille2)
  {
    int out0 = 0;
    for (int i = 0 ; i < taille1; i++)
    {
      out0 += tableau1[i] * i;
      System.out.printf("%c", tableau1[i]);
    }
    System.out.print("--\n");
    for (int j = 0 ; j < taille2; j++)
    {
      out0 += tableau2[j] * j * 100;
      System.out.printf("%c", tableau2[j]);
    }
    System.out.print("--\n");
    return out0;
  }
  
  
  public static void main(String args[])
  {
    int taille1 = Integer.parseInt(scanner.nextLine());
    char[] tableau1 = scanner.nextLine().toCharArray();
    int taille2 = Integer.parseInt(scanner.nextLine());
    char[] tableau2 = scanner.nextLine().toCharArray();
    System.out.printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  }
  
}

