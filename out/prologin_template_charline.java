import java.util.*;

public class prologin_template_charline
{
  static Scanner scanner = new Scanner(System.in);
  public static int programme_candidat(char[] tableau, int taille)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille; i++)
    {
      out_ += tableau[i] * i;
      System.out.printf("%c", tableau[i]);
    }
    System.out.print("--\n");
    return out_;
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
    char[] tableau = scanner.nextLine().toCharArray();
    System.out.printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

