import java.util.*;

public class prologin_template_intlist
{
  static Scanner scanner = new Scanner(System.in);
  public static int programme_candidat(int[] tableau, int taille)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille; i++)
      out_ += tableau[i];
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int b = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); b = -scanner.nextInt();
    }else{
    b = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille = b;
    int[] d = new int[taille];
    for (int e = 0 ; e < taille; e++)
    {
      int f = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); f = -scanner.nextInt();
      }else{
      f = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      d[e] = f;
    }
    int[] tableau = d;
    System.out.printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

