import java.util.*;

public class prologin_template_charmatrix
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
  
  public static char[][] read_char_matrix(int x, int y)
  {
    char[][] tab = new char[y][];
    for (int z = 0 ; z < y; z++)
    {
      int b = x;
      char[] a = scanner.nextLine().toCharArray();
      tab[z] = a;
    }
    return tab;
  }
  
  public static int programme_candidat(char[][] tableau, int taille_x, int taille_y)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille_y; i++)
    {
      for (int j = 0 ; j < taille_x; j++)
      {
        out_ += tableau[i][j] * (i + j * 2);
        System.out.printf("%c", tableau[i][j]);
      }
      System.out.print("--\n");
    }
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int d = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); d = -scanner.nextInt();
    }else{
    d = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int c = d;
    int taille_x = c;
    int f = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); f = -scanner.nextInt();
    }else{
    f = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int e = f;
    int taille_y = e;
    char[][] tableau = read_char_matrix(taille_x, taille_y);
    System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

