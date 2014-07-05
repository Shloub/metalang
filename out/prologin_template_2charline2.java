import java.util.*;

public class prologin_template_2charline2
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
  
  public static int programme_candidat(char[] tableau1, int taille1, char[] tableau2, int taille2)
  {
    int out_ = 0;
    for (int i = 0 ; i < taille1; i++)
    {
      out_ += tableau1[i] * i;
      char a = tableau1[i];
      System.out.printf("%c", a);
    }
    System.out.print("--\n");
    for (int j = 0 ; j < taille2; j++)
    {
      out_ += tableau2[j] * j * 100;
      char b = tableau2[j];
      System.out.printf("%c", b);
    }
    System.out.print("--\n");
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int taille1 = read_int();
    int taille2 = read_int();
    char[] tableau1 = read_char_line(taille1);
    char[] tableau2 = read_char_line(taille2);
    int c = programme_candidat(tableau1, taille1, tableau2, taille2);
    System.out.printf("%d\n", c);
  }
  
}

