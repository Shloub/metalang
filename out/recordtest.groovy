import java.util.*;

public class recordtest
{
  static Scanner scanner = new Scanner(System.in);
  static class Toto {
    int foo;
    int bar;
  }
  
  static void main(String[] args)
  {
    Toto param = new Toto();
    param.foo = 0;
    param.bar = 0;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      param.bar = -scanner.nextInt();
    }else{
      param.bar = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      param.foo = -scanner.nextInt();
    }else{
      param.foo = scanner.nextInt();
    }
    print(param.bar + param.foo * param.bar);
  }
  
}

