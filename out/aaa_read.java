import java.util.*;

public class aaa_read
{
  static Scanner scanner = new Scanner(System.in);
  
  
  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  public static void main(String args[])
  {
    int len = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); len = -scanner.nextInt();
    }else{
    len = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%d%s", len, "=len\n");
    int[] tab = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      int tmpi1 = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); tmpi1 = -scanner.nextInt();
      }else{
      tmpi1 = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      System.out.printf("%d%s%d%s", i, "=>", tmpi1, " ");
      tab[i] = tmpi1;
    }
    System.out.print("\n");
    int[] tab2 = new int[len];
    for (int i_ = 0 ; i_ < len; i_++)
    {
      int tmpi2 = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); tmpi2 = -scanner.nextInt();
      }else{
      tmpi2 = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      System.out.printf("%d%s%d%s", i_, "==>", tmpi2, " ");
      tab2[i_] = tmpi2;
    }
    int strlen = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); strlen = -scanner.nextInt();
    }else{
    strlen = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%d%s", strlen, "=strlen\n");
    char[] tab4 = new char[strlen];
    for (int toto = 0 ; toto < strlen; toto++)
    {
      char tmpc = '_';
      scanner.useDelimiter("\\n");tmpc = scanner.findWithinHorizon(".", 1).charAt(0);
      int c = tmpc;
      System.out.printf("%c%s%d%s", tmpc, ":", c, " ");
      if (tmpc != ' ')
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[toto] = (char)(c);
    }
    for (int j = 0 ; j < strlen; j++)
    {
      char a = tab4[j];
      System.out.printf("%c", a);
    }
  }
  
}

