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
    int b;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      b = scanner.nextInt();
    } else {
      b = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int len = b;
    System.out.printf("%d=len\n", len);
    int[] e = new int[len];
    for (int f = 0 ; f < len; f++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        e[f] = -scanner.nextInt();
      }else{
        e[f] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    int[] tab = e;
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d=>%d ", i, tab[i]);
    }
    System.out.print("\n");
    int[] k = new int[len];
    for (int l = 0 ; l < len; l++)
    {
      if (scanner.hasNext("^-")){
        scanner.next("^-");
        k[l] = -scanner.nextInt();
      }else{
        k[l] = scanner.nextInt();
      }
      scanner.findWithinHorizon("[\n\r ]*", 1);
    }
    int[] tab2 = k;
    for (int i_ = 0 ; i_ < len; i_++)
    {
      System.out.printf("%d==>%d ", i_, tab2[i_]);
    }
    int p;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      p = scanner.nextInt();
    } else {
      p = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int strlen = p;
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

