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
    for (int j = 0 ; j < len; j++)
    {
      t[j].blah = t[j].blah + 1;
      out_ = out_ + t[j].foo + t[j].blah * t[j].bar + t[j].bar * t[j].foo;
    }
    return out_;
  }
  
  
  public static void main(String args[])
  {
    toto[] t = new toto[4];
    for (int i = 0 ; i < 4; i++)
      t[i] = mktoto(i);
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      t[0].bar = -scanner.nextInt();
    }else{
      t[0].bar = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      t[1].blah = -scanner.nextInt();
    }else{
      t[1].blah = scanner.nextInt();
    }
    int titi = result(t, 4);
    System.out.printf("%d%d", titi, t[2].blah);
  }
  
}

