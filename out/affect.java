import java.util.*;

public class affect
{
  static Scanner scanner = new Scanner(System.in);
  /*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/
  static class toto {public int foo;public int bar;public int blah;}
  public static toto mktoto(int v1)
  {
    toto t__ = new toto();
    t__.foo = v1;
    t__.bar = v1;
    t__.blah = v1;
    return t__;
  }
  
  public static int result(toto t_, toto t2_)
  {
    toto t__ = t_;
    toto t2 = t2_;
    toto t3 = new toto();
    t3.foo = 0;
    t3.bar = 0;
    t3.blah = 0;
    t3 = t2;
    t__ = t2;
    t2 = t3;
    t__.blah ++;
    int len = 1;
    int[] cache0 = new int[len];
    for (int i = 0 ; i < len; i++)
      cache0[i] = -i;
    int[] cache1 = new int[len];
    for (int j = 0 ; j < len; j++)
      cache1[j] = j;
    int[] cache2 = cache0;
    cache0 = cache1;
    cache2 = cache0;
    return t__.foo + t__.blah * t__.bar + t__.bar * t__.foo;
  }
  
  
  public static void main(String args[])
  {
    toto t__ = mktoto(4);
    toto t2 = mktoto(5);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t__.bar = -scanner.nextInt();
    }else{
    t__.bar = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t__.blah = -scanner.nextInt();
    }else{
    t__.blah = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t2.bar = -scanner.nextInt();
    }else{
    t2.bar = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t__.blah = -scanner.nextInt();
    }else{
    t__.blah = scanner.nextInt();}
    int a = result(t__, t2);
    System.out.printf("%d", a);
    int b = t__.blah;
    System.out.printf("%d", b);
  }
  
}

