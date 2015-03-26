import java.util.*;

public class prologin_template_intlist
{
  static Scanner scanner = new Scanner(System.in);
  static int programme_candidat(int[] tableau, int taille)
  {
    int out0 = 0;
    for (int i = 0 ; i < taille; i++)
      out0 += tableau[i];
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
    int[] tableau = new int[taille];
    for (int a = 0 ; a < taille; a++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tableau[a] = -scanner.nextInt();
      }else{
        tableau[a] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    System.out.printf("%s\n", programme_candidat(tableau, taille));
  }
  
}

