import java.util.*;

public class prologin_template_charline
{
  static Scanner scanner = new Scanner(System.in);
  static int programme_candidat(char[] tableau, int taille)
  {
    int out0 = 0;
    for (int i = 0 ; i < taille; i++)
    {
      out0 += tableau[i] * i;
      print(tableau[i]);
    }
    print("--\n");
    return out0;
  }
  
  
  static void main(String[] args)
  {
    int taille;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      taille = scanner.nextInt();
    } else {
      taille = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[] tableau = new char[taille];
    for (int a = 0 ; a < taille; a++)
      tableau[a] = scanner.findWithinHorizon(".", 1).charAt(0);
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%s\n", programme_candidat(tableau, taille));
  }
  
}

