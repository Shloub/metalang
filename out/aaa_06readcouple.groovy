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


@Field Scanner scanner = new Scanner(System.in)
for (int i = 1; i < 4; i++)
{
    int[] c = read_int_line()
    int a = c[0]
    int b = c[1]
    System.out.printf("a = %d b = %d\n", a, b)
}
int[] l = read_int_line()
for (int j = 0; j < 10; j++)
    System.out.printf("%d\n", l[j])

