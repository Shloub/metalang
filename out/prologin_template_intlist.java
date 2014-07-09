import java.util.*;

public class prologin_template_intlist
{
  static Scanner scanner = new Scanner(System.in);
  public static int read_int()
  {
    int out_ = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); out_ = -scanner.nextInt();
    }else{
    out_ = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    return out_;
  }
  
  public static int[] read_int_line(int n)
  {
    int[] tab = new int[n];
    for (int i = 0 ; i < n; i++)
    {
      int t = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); t = -scanner.nextInt();
      }else{
      t = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i] = t;
    }
    return tab;
  }
  
  public static int programme_candidat(int[] tableau, int taille)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille; i++)
      out_ += tableau[i];
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int taille = read_int();
    int[] tableau = read_int_line(taille);
    System.out.printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

