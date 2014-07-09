import java.util.*;

public class prologin_template_charline
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
  
  public static char[] read_char_line(int n)
  {
    return scanner.nextLine().toCharArray();
  }
  
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
    int taille = read_int();
    char[] tableau = read_char_line(taille);
    System.out.printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

