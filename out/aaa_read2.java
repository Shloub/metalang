import java.util.*;

public class aaa_read2
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
  
  public static int[] read_int_line(int n)
  {
    int[] tab = new int[n];
    for (int i = 0 ; i < n; i++)
    {
      int t = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); t = -scanner.nextInt();
      }else{
      t = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      tab[i] = t;
    }
    return tab;
  }
  
  public static char[] read_char_line(int n)
  {
    char[] tab = new char[n];
    for (int i = 0 ; i < n; i++)
    {
      char t = '_';
      t = scanner.findWithinHorizon(".", 1).charAt(0);
      tab[i] = t;
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    return tab;
  }
  
  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  public static void main(String args[])
  {
    int len = read_int();
    System.out.printf("%d%s", len, "=len\n");
    int[] tab = read_int_line(len);
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d%s", i, "=>");
      int a = tab[i];
      System.out.printf("%d%s", a, " ");
    }
    System.out.print("\n");
    int[] tab2 = read_int_line(len);
    for (int i_ = 0 ; i_ < len; i_++)
    {
      System.out.printf("%d%s", i_, "==>");
      int b = tab2[i_];
      System.out.printf("%d%s", b, " ");
    }
    int strlen = read_int();
    System.out.printf("%d%s", strlen, "=strlen\n");
    char[] tab4 = read_char_line(strlen);
    for (int i3 = 0 ; i3 < strlen; i3++)
    {
      char tmpc = tab4[i3];
      int c = tmpc;
      System.out.printf("%c%s%d%s", tmpc, ":", c, " ");
      if (tmpc != ' ')
        c = ((c - 'a') + 13) % 26 + 'a';
      tab4[i3] = (char)(c);
    }
    for (int j = 0 ; j < strlen; j++)
    {
      char d = tab4[j];
      System.out.printf("%c", d);
    }
  }
  
}

