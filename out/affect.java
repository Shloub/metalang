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
    toto c = new toto();
    c.foo = v1;
    c.bar = v1;
    c.blah = v1;
    toto t = c;
    return t;
  }
  
  public static toto mktoto2(int v1)
  {
    toto d = new toto();
    d.foo = v1 + 3;
    d.bar = v1 + 2;
    d.blah = v1 + 1;
    toto t = d;
    return t;
  }
  
  public static int result(toto t_, toto t2_)
  {
    toto t = t_;
    toto t2 = t2_;
    toto e = new toto();
    e.foo = 0;
    e.bar = 0;
    e.blah = 0;
    toto t3 = e;
    t3 = t2;
    t = t2;
    t2 = t3;
    t.blah ++;
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
    return t.foo + t.blah * t.bar + t.bar * t.foo;
  }
  
  
  public static void main(String args[])
  {
    toto t = mktoto(4);
    toto t2 = mktoto(5);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t.bar = -scanner.nextInt();
    }else{
    t.bar = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t.blah = -scanner.nextInt();
    }else{
    t.blah = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t2.bar = -scanner.nextInt();
    }else{
    t2.bar = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t.blah = -scanner.nextInt();
    }else{
    t.blah = scanner.nextInt();}
    int a = result(t, t2);
    System.out.printf("%d", a);
    int b = t.blah;
    System.out.printf("%d", b);
  }
  
}

