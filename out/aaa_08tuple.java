import java.util.*;

public class aaa_08tuple
{
  static Scanner scanner = new Scanner(System.in);
  static int[] read_int_line()
  {
    String[] s = scanner.nextLine().split(" ");
    int[] out = new int[s.length];
    for (int i = 0; i < s.length; i++)
      out[i] = Integer.parseInt(s[i]);
    return out;
  }

  
  
  static class tuple_int_int {
    public int tuple_int_int_field_0;
    public int tuple_int_int_field_1;
  }
  static class toto {
    public tuple_int_int foo;
    public int bar;
  }
  public static void main(String args[])
  {
    int bar_ = Integer.parseInt(scanner.nextLine());
    int[] c = read_int_line();
    tuple_int_int d = new tuple_int_int();
    d.tuple_int_int_field_0 = c[0];
    d.tuple_int_int_field_1 = c[1];
    toto t = new toto();
    t.foo = d;
    t.bar = bar_;
    tuple_int_int e = t.foo;
    int a = e.tuple_int_int_field_0;
    int b = e.tuple_int_int_field_1;
    System.out.printf("%d %d %d\n", a, b, t.bar);
  }
  
}

