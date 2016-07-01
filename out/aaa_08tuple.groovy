import groovy.transform.Field
import java.util.*

  int[] read_int_line()
  {
    String[] s = scanner.nextLine().split(" ");
    int[] out = new int[s.length];
    for (int i = 0; i < s.length; i++)
      out[i] = Integer.parseInt(s[i]);
    return out;
  }

class Tuple_int_int {
  int tuple_int_int_field_0
  int tuple_int_int_field_1
}
class Toto {
  Tuple_int_int foo
  int bar
}

@Field Scanner scanner = new Scanner(System.in)
int bar_ = Integer.parseInt(scanner.nextLine())
int[] c = read_int_line()
Tuple_int_int d = new Tuple_int_int()
d.tuple_int_int_field_0 = c[0]
d.tuple_int_int_field_1 = c[1]
Toto t = new Toto()
t.foo = d
t.bar = bar_
Tuple_int_int e = t.foo
int a = e.tuple_int_int_field_0
int b = e.tuple_int_int_field_1
System.out.printf("%d %d %d\n", a, b, t.bar)

