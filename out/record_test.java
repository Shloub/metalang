import java.util.*;

public class record_test
{
  static Scanner scanner = new Scanner(System.in);
  static class toto {public int foo;public int bar;}
  
  public static void main(String args[])
  {
    toto param = new toto();
    param.foo = 0;
    param.bar = 0;
    scanner.useDelimiter("\\s");
    param.bar = scanner.nextInt();
    scanner.useDelimiter("\\r*\\n*\\s*");scanner.next();
    scanner.useDelimiter("\\s");
    param.foo = scanner.nextInt();
    int e = param.bar + (param.foo * param.bar);
    System.out.printf("%d", e);
  }
  
}

