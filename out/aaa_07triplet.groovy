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
for (int i = 1; i < 4; i += 1)
{
    int[] d = read_int_line()
    int a = d[0]
    int b = d[1]
    int c = d[2]
    System.out.printf("a = %d b = %dc =%d\n", a, b, c)
}
int[] l = read_int_line()
for (int j = 0; j < 10; j += 1)
    System.out.printf("%d\n", l[j])

