import java.util.*;

public class aaa_integer
{
  static Scanner scanner = new Scanner(System.in);
  
  
  public static void main(String args[])
  {
    int i = 0;
    i --;
    System.out.printf("%d%s", i, "\n");
    i += 55;
    System.out.printf("%d%s", i, "\n");
    i *= 13;
    System.out.printf("%d%s", i, "\n");
    i /= 2;
    System.out.printf("%d%s", i, "\n");
    i ++;
    System.out.printf("%d%s", i, "\n");
    i /= 3;
    System.out.printf("%d%s", i, "\n");
    i --;
    System.out.printf("%d%s", i, "\n");
    /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
    int a = 117 / 17;
    System.out.printf("%d%s", a, "\n");
    int b = 117 / -17;
    System.out.printf("%d%s", b, "\n");
    int c = -117 / 17;
    System.out.printf("%d%s", c, "\n");
    int d = -117 / -17;
    System.out.printf("%d%s", d, "\n");
    int e = 117 % 17;
    System.out.printf("%d%s", e, "\n");
    int f = 117 % -17;
    System.out.printf("%d%s", f, "\n");
    int g = -117 % 17;
    System.out.printf("%d%s", g, "\n");
    int h = -117 % -17;
    System.out.printf("%d%s", h, "\n");
  }
  
}

