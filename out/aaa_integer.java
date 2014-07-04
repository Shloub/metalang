import java.util.*;

public class aaa_integer
{
  static Scanner scanner = new Scanner(System.in);
  
  public static void main(String args[])
  {
    int i = 0;
    i --;
    System.out.printf("%d\n", i);
    i += 55;
    System.out.printf("%d\n", i);
    i *= 13;
    System.out.printf("%d\n", i);
    i /= 2;
    System.out.printf("%d\n", i);
    i ++;
    System.out.printf("%d\n", i);
    i /= 3;
    System.out.printf("%d\n", i);
    i --;
    System.out.printf("%d\n", i);
    /*
http://fr.wikipedia.org/wiki/Modulo_(op%C3%A9ration)#Trois_d.C3.A9finitions_de_la_fonction_modulo
*/
    int a = 117 / 17;
    System.out.printf("%d\n", a);
    int b = 117 / -17;
    System.out.printf("%d\n", b);
    int c = -117 / 17;
    System.out.printf("%d\n", c);
    int d = -117 / -17;
    System.out.printf("%d\n", d);
    int e = 117 % 17;
    System.out.printf("%d\n", e);
    int f = 117 % -17;
    System.out.printf("%d\n", f);
    int g = -117 % 17;
    System.out.printf("%d\n", g);
    int h = -117 % -17;
    System.out.printf("%d\n", h);
  }
  
}

