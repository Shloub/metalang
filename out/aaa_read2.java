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
    return scanner.nextLine().toCharArray();
  }
  
  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  public static void main(String args[])
  {
    int b = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); b = -scanner.nextInt();
    }else{
    b = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int a = b;
    int len = a;
    System.out.printf("%d=len\n", len);
    int e = len;
    int[] f = new int[e];
    for (int g = 0 ; g < e; g++)
    {
      int h = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); h = -scanner.nextInt();
      }else{
      h = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      f[g] = h;
    }
    int[] d = f;
    int[] tab = d;
    for (int i = 0 ; i < len; i++)
    {
      System.out.printf("%d=>%d ", i, tab[i]);
    }
    System.out.print("\n");
    int l = len;
    int[] m = new int[l];
    for (int o = 0 ; o < l; o++)
    {
      int p = 0;
      if (scanner.hasNext("^-")){
      scanner.next("^-"); p = -scanner.nextInt();
      }else{
      p = scanner.nextInt();}
      scanner.findWithinHorizon("[\n\r ]*", 1);
      m[o] = p;
    }
    int[] k = m;
    int[] tab2 = k;
    for (int i_ = 0 ; i_ < len; i_++)
    {
      System.out.printf("%d==>%d ", i_, tab2[i_]);
    }
    int r = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); r = -scanner.nextInt();
    }else{
    r = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int q = r;
    int strlen = q;
    System.out.printf("%d=strlen\n", strlen);
    int u = strlen;
    char[] s = scanner.nextLine().toCharArray();
    char[] tab4 = s;
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

