import java.util.*;

public class prologin_template_2charline2
{
  static Scanner scanner = new Scanner(System.in);
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
    int d = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); d = -scanner.nextInt();
    }else{
    d = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int c = d;
    int taille2 = c;
    char[] e = scanner.nextLine().toCharArray();
    char[] tableau1 = e;
    char[] f = scanner.nextLine().toCharArray();
    char[] tableau2 = f;
    System.out.printf("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  }
  
}

