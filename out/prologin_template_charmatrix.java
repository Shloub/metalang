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
      tab[z] = read_char_line(x);
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
        char a = tableau[i][j];
        System.out.printf("%c", a);
      }
      System.out.print("--\n");
    }
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int taille_x = read_int();
    int taille_y = read_int();
    char[][] tableau = read_char_matrix(taille_x, taille_y);
    int b = programme_candidat(tableau, taille_x, taille_y);
    System.out.printf("%d\n", b);
  }
  
}

