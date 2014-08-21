import java.util.*;

public class prologin_template_charmatrix
{
  static Scanner scanner = new Scanner(System.in);
  public static char[][] read_char_matrix(int x, int y)
  {
    char[][] tab = new char[y][];
    for (int z = 0 ; z < y; z++)
    {
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
    int c = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); c = -scanner.nextInt();
    }else{
    c = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int b = c;
    int taille_x = b;
    int e = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); e = -scanner.nextInt();
    }else{
    e = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int d = e;
    int taille_y = d;
    char[][] tableau = read_char_matrix(taille_x, taille_y);
    System.out.printf("%d\n", programme_candidat(tableau, taille_x, taille_y));
  }
  
}

