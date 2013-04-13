import java.util.*;

public class affect
{
  static Scanner scanner = new Scanner(System.in);
  static class toto {public int foo;public int bar;public int blah;}
  public static toto mktoto(int v1)
  {
    toto t = new toto();
    t.foo = v1;
    t.bar = v1;
    t.blah = v1;
    return t;
  }
  
  public static int result(toto t_, toto t2_)
  {
    toto t = t_;
    toto t2 = t2_;
    toto t3 = new toto();
    t3.foo = 0;
    t3.bar = 0;
    t3.blah = 0;
    t3 = t2;
    t = t2;
    t2 = t3;
    t.blah = t.blah + 1;
    int len = 1;
    int[] cache0 = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      cache0[i] = -i;
    }
    int[] cache1 = new int[len];
    for (int i = 0 ; i < len; i++)
    {
      cache1[i] = i;
    }
    int[] cache2 = cache0;
    cache0 = cache1;
    cache2 = cache0;
    return t.foo + t.blah * t.bar + t.bar * t.foo;
  }
  
  
  public static void main(String args[])
  {
    toto t = mktoto(4);
    toto t2 = mktoto(5);
    scanner.useDelimiter("\\s");
    t.bar = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    t.blah = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    t2.bar = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    t.blah = scanner.nextInt();
    int k = result(t, t2);
    System.out.printf("%d", k);
    int l = t.blah;
    System.out.printf("%d", l);
  }
  
}

