import java.util.*;

public class aaa_08tuple
{
  static Scanner scanner = new Scanner(System.in);
  static class Tuple_int_int {
    int tuple_int_int_field_0;
    int tuple_int_int_field_1;
  }
  static class Toto {
    Tuple_int_int foo;
    int bar;
  }
  
  static void main(String[] args)
  {
    int bar_;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      bar_ = scanner.nextInt();
    } else {
      bar_ = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int c;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      c = scanner.nextInt();
    } else {
      c = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    int d;
    if (scanner.hasNext("^-")){
      scanner.next("^-");
      d = scanner.nextInt();
    } else {
      d = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    Tuple_int_int e = new Tuple_int_int();
    e.tuple_int_int_field_0 = c;
    e.tuple_int_int_field_1 = d;
    Toto t = new Toto();
    t.foo = e;
    t.bar = bar_;
    Tuple_int_int f = t.foo;
    int a = f.tuple_int_int_field_0;
    int b = f.tuple_int_int_field_1;
    System.out.printf("%s %s %s\n", a, b, t.bar);
  }
  
}

