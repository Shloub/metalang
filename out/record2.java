import java.util.*;

public class record2
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
  
  public static int result(toto t_)
  {
    t_.blah ++;
    return t_.foo + t_.blah * t_.bar + t_.bar * t_.foo;
  }
  
  
  public static void main(String args[])
  {
    toto t_ = mktoto(4);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t_.bar = -scanner.nextInt();
    }else{
    t_.bar = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t_.blah = -scanner.nextInt();
    }else{
    t_.blah = scanner.nextInt();}
    int a = result(t_);
    System.out.printf("%d", a);
    int b = t_.blah;
    System.out.printf("%d", b);
  }
  
}

