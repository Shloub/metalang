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
    if (scanner.hasNext("^-")){
    scanner.next("^-"); strlen = -scanner.nextInt();
    }else{
    strlen = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    char[] tab4 = new char[strlen];
    for (int toto = 0 ; toto < strlen; toto++)
    {
      char tmpc = '_';
      scanner.useDelimiter("\\n");tmpc = scanner.findWithinHorizon(".", 1).charAt(0);
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

