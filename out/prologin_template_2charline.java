import java.util.*;

public class prologin_template_2charline
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
      System.out.printf("%c", tableau1[i]);
    }
    System.out.print("--\n");
    for (int j = 0 ; j < taille2; j++)
    {
      out_ += tableau2[j] * j * 100;
      System.out.printf("%c", tableau2[j]);
    }
    System.out.print("--\n");
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
    int taille1 = a;
    int d = taille1;
    char[] c = scanner.nextLine().toCharArray();
    char[] tableau1 = c;
    int f = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); f = -scanner.nextInt();
    }else{
    f = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int e = f;
    int taille2 = e;
    int h = taille2;
    char[] g = scanner.nextLine().toCharArray();
    char[] tableau2 = g;
    System.out.printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  }
  
}

