import java.util.*;

public class sumDiv
{
  static Scanner scanner = new Scanner(System.in);
  public static int sumdiv(int n)
  {
    /* On désire renvoyer la somme des diviseurs */
    int out_ = 0;
    /* On déclare un entier qui contiendra la somme */
    for (int i = 1 ; i <= n; i ++)
    {
      /* La boucle : i est le diviseur potentiel*/
      if ((n % i) == 0)
      {
        /* Si i divise */
        out_ += i;
        /* On incrémente */
      }
      else
      {
        /* nop */
      }
    }
    return out_;
    /*On renvoie out*/
  }
  
  
  public static void main(String args[])
  {
    /* Programme principal */
    int n = 0;
    scanner.useDelimiter("\\s");
    n = scanner.nextInt();
    /* Lecture de l'entier */
    int e = sumdiv(n);
    System.out.printf("%d", e);
  }
  
}

