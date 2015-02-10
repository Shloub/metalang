import java.util.*;

public class prologin_template_intlist
{
  static Scanner scanner = new Scanner(System.in);
    static int[] read_int_line(){
        String s[] = scanner.nextLine().split(" ");
        int out[] = new int[s.length];
        for (int i = 0; i < s.length; i ++)
          out[i] = Integer.parseInt(s[i]);
        return out;
    }

  public static int programme_candidat(int[] tableau, int taille)
  {
    int out0 = 0;
    for (int i = 0 ; i < taille; i++)
      out0 += tableau[i];
    return out0;
  }
  
  
  public static void main(String args[])
  {
    int taille = Integer.parseInt(scanner.nextLine());
    int[] tableau = read_int_line();
    System.out.printf("%d\n", programme_candidat(tableau, taille));
  }
  
}

