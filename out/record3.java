import java.util.*;

public class record3
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
  
  public static int result(toto[] t, int len)
  {
    int out_ = 0;
    for (int j = 0 ; j <= len - 1; j ++)
    {
      t[j].blah = t[j].blah + 1;
      out_ = ((out_ + t[j].foo) + (t[j].blah * t[j].bar)) + (t[j].bar * t[j].foo);
    }
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int p = 4;
    toto[] t = new toto[p];
    for (int i = 0 ; i <= p - 1; i ++)
    {
      t[i] = mktoto(i);
    }
    scanner.useDelimiter("\\s");
    t[0].bar = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    t[1].blah = scanner.nextInt();
    int q = result(t, 4);
    System.out.printf("%d", q);
    int r = t[2].blah;
    System.out.printf("%d", r);
  }
  
}
