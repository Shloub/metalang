import java.util.*;

public class prologin_template_2charline2
{
  static Scanner scanner = new Scanner(System.in);
  static int programme_candidat(char[] tableau1, int taille1, char[] tableau2, int taille2)
  {
    int out0 = 0;
    for (int i = 0 ; i < taille1; i++)
    {
      out0 += tableau1[i] * i;
      print(tableau1[i]);
    }
    print("--\n");
    for (int j = 0 ; j < taille2; j++)
    {
      out0 += tableau2[j] * j * 100;
      print(tableau2[j]);
    }
    print("--\n");
    return out0;
  }
  
  
  static void main(String[] args)
  {
    int taille1;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      taille1 = scanner.nextInt();
    } else {
      taille1 = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int taille2;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      taille2 = scanner.nextInt();
    } else {
      taille2 = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[] tableau1 = new char[taille1];
    for (int a = 0 ; a < taille1; a++)
      tableau1[a] = scanner.findWithinHorizon(".", 1).charAt(0);
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[] tableau2 = new char[taille2];
    for (int b = 0 ; b < taille2; b++)
      tableau2[b] = scanner.findWithinHorizon(".", 1).charAt(0);
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%s\n", programme_candidat(tableau1, taille1, tableau2, taille2));
  }
  
}

