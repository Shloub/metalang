import java.util.*;

public class aaa_read2
{
  static Scanner scanner = new Scanner(System.in);
  static int[] read_int_line()
  {
    String[] s = scanner.nextLine().split(" ");
    int[] out = new int[s.length];
    for (int i = 0; i < s.length; i++)
      out[i] = Integer.parseInt(s[i]);
    return out;
  }

  /*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
  
  public static void main(String args[])
  {
    int len = Integer.parseInt(scanner.nextLine());
    System.out.printf("%d=len\n", len);
    int[] tab = read_int_line();
    for (int i = 0; i < len; i++)
        System.out.printf("%d=>%d ", i, tab[i]);
    System.out.print("\n");
    int[] tab2 = read_int_line();
    for (int i_ = 0; i_ < len; i_++)
        System.out.printf("%d==>%d ", i_, tab2[i_]);
    int strlen = Integer.parseInt(scanner.nextLine());
    System.out.printf("%d=strlen\n", strlen);
    char[] tab4 = scanner.nextLine().toCharArray();
    for (int i3 = 0; i3 < strlen; i3++)
    {
        char tmpc = tab4[i3];
        int c = (int)(tmpc);
        System.out.printf("%c:%d ", tmpc, c);
        if (tmpc != ' ')
            c = (c - (int)('a') + 13) % 26 + (int)('a');
        tab4[i3] = (char)(c);
    }
    for (int j = 0; j < strlen; j++)
        System.out.print(tab4[j]);
  }
  
}

