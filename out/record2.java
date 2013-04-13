import java.util.*;

public class record2
{
  static Scanner scanner = new Scanner(System.in);
  static class toto {public int foo;public int bar;public int blah;}
  public static toto mktoto(int v1)
  {
    toto t = new toto();
    t.foo = v1;
    t.bar = 0;
    t.blah = 0;
    return t;
  }
  
  public static int result(toto t)
  {
    t.blah = t.blah + 1;
    return (t.foo + (t.blah * t.bar)) + (t.bar * t.foo);
  }
  
  
  public static void main(String args[])
  {
    toto t = mktoto(4);
    scanner.useDelimiter("\\s");
    t.bar = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    t.blah = scanner.nextInt();
    int i = result(t);
    System.out.printf("%d", i);
    int j = t.blah;
    System.out.printf("%d", j);
  }
  
}

