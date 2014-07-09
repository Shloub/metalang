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
    System.out.printf("%d\n%d\n%d\n%d\n%d\n%d\n%d\n%d\n", 117 / 17, 117 / -17, -117 / 17, -117 / -17, 117 % 17, 117 % -17, -117 % 17, -117 % -17);
  }
  
}

