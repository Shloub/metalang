import java.util.*;

public class prologin_template_intlist
{
  static Scanner scanner = new Scanner(System.in);
  public static int programme_candidat(int[] tableau, int taille)
  {
    int out0 = 0;
    for (int i = 0 ; i < taille; i++)
      out0 += tableau[i];
    return out0;
  }
  
  
  public static void main(String args[])
  {
    int b;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      b = scanner.nextInt();
    } else {
      b = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille = b;
    int[] tableau = new int[taille];
    for (int e = 0 ; e < taille; e++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tableau[e] = -scanner.nextInt();
      }else{
        tableau[e] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    System.out.printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

