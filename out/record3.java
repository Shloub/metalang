import java.util.*;

public class record3
{
  static Scanner scanner = new Scanner(System.in);
  static class toto {public int foo;public int bar;public int blah;}
  public static toto mktoto(int v1)
  {
    toto t_ = new toto();
    t_.foo = v1;
    t_.bar = 0;
    t_.blah = 0;
    return t_;
  }
  
  public static int result(toto[] t_, int len)
  {
    int out_ = 0;
    for (int j = 0 ; j < len; j++)
    {
      t_[j].blah = t_[j].blah + 1;
      out_ = out_ + t_[j].foo + t_[j].blah * t_[j].bar + t_[j].bar * t_[j].foo;
    }
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int a = 4;
    toto[] t_ = new toto[a];
    for (int i = 0 ; i < a; i++)
      t_[i] = mktoto(i);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t_[0].bar = -scanner.nextInt();
    }else{
    t_[0].bar = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t_[1].blah = -scanner.nextInt();
    }else{
    t_[1].blah = scanner.nextInt();}
    int b = result(t_, 4);
    System.out.printf("%d", b);
    int c = t_[2].blah;
    System.out.printf("%d", c);
  }
  
}

