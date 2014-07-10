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
    int b = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); b = -scanner.nextInt();
    }else{
    b = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int a = b;
    int taille = a;
    int d = taille;
    int[] e = new int[d];
    for (int f = 0 ; f < d; f++)
    {
      int g = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); g = -scanner.nextInt();
      }else{
      g = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      e[f] = g;
    }
    int[] c = e;
    int[] tableau = c;
    System.out.printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

