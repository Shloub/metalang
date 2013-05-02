import java.util.*;

public class rot13
{
  static Scanner scanner = new Scanner(System.in);
  
  
  /*
Ce test effectue un rot13 sur une chaine lue en entrée
*/
  
  public static void main(String args[])
  {
    int strlen = 0;
    scanner.useDelimiter("\\s");
    strlen = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    char[] tab4 = new char[strlen];
    for (int toto = 0 ; toto < strlen; toto++)
    {
      char tmpc = '_';
      tmpc = scanner.findWithinHorizon(".", 1).charAt(0);
      int c = tmpc;
      if (tmpc != ' ')
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[toto] = (char)(c);
    }
    for (int j = 0 ; j < strlen; j++)
    {
      char f = tab4[j];
      System.out.printf("%c", f);
    }
  }
  
}

