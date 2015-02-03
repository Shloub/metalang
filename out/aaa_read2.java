import java.util.*;

public class aaa_read2
{
  static Scanner scanner = new Scanner(System.in);
  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  public static void main(String args[])
  {
    int len;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      len = scanner.nextInt();
    } else {
      len = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%d=len\n", len);
    int[] tab = new int[len];
    for (int f = 0 ; f < len; f++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tab[f] = -scanner.nextInt();
      }else{
        tab[f] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d=>%d ", i, tab[i]);
    }
    System.out.print("\n");
    int[] tab2 = new int[len];
    for (int l = 0 ; l < len; l++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        tab2[l] = -scanner.nextInt();
      }else{
        tab2[l] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    for (int i_ = 0 ; i_ < len; i_++)
    {
      System.out.printf("%d==>%d ", i_, tab2[i_]);
    }
    int strlen;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      strlen = scanner.nextInt();
    } else {
      strlen = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    System.out.printf("%d=strlen\n", strlen);
    char[] tab4 = scanner.nextLine().toCharArray();
    for (int i3 = 0 ; i3 < strlen; i3++)
    {
      char tmpc = tab4[i3];
      int c = tmpc;
      System.out.printf("%c:%d ", tmpc, c);
      if (tmpc != ' ')
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[i3] = (char)(c);
    }
    for (int j = 0 ; j < strlen; j++)
      System.out.printf("%c", tab4[j]);
  }
  
}

