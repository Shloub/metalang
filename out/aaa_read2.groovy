import java.util.*;

public class aaa_read2
{
  static Scanner scanner = new Scanner(System.in);
  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  static void main(String[] args)
  {
    int len;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      len = scanner.nextInt();
    } else {
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%s=len\n", len);
    int[] tab = new int[len];
    for (int a = 0 ; a < len; a++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tab[a] = -scanner.nextInt();
      }else{
        tab[a] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%s=>%s ", i, tab[i]);
    }
    print("\n");
    int[] tab2 = new int[len];
    for (int b = 0 ; b < len; b++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tab2[b] = -scanner.nextInt();
      }else{
        tab2[b] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    for (int i_ = 0 ; i_ < len; i_++)
    {
      System.out.printf("%s==>%s ", i_, tab2[i_]);
    }
    int strlen;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      strlen = scanner.nextInt();
    } else {
      strlen = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%s=strlen\n", strlen);
    char[] tab4 = new char[strlen];
    for (int d = 0 ; d < strlen; d++)
      tab4[d] = scanner.findWithinHorizon(".", 1).charAt(0);
    scanner.findWithinHorizon("[\n\r ]*", 1);
    for (int i3 = 0 ; i3 < strlen; i3++)
    {
      char tmpc = tab4[i3];
      int c = tmpc;
      System.out.printf("%s:%s ", tmpc, c);
      if (tmpc != (char)' ')
        c = ((c - (char)'a') + 13) % 26 + (char)'a';
      tab4[i3] = (char)(c);
    }
    for (int j = 0 ; j < strlen; j++)
      print(tab4[j]);
  }
  
}

