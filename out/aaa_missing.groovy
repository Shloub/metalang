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

/*
  Ce test a été généré par Metalang.
*/
int result(int len, int[] tab)
{
  boolean[] tab2 = new boolean[len]
  for (int i = 0; i < len; i++)
    tab2[i] = false
  for (int i1 = 0; i1 < len; i1++)
  {
      System.out.printf("%s ", tab[i1]);
      tab2[tab[i1]] = true
  }
  print("\n")
  for (int i2 = 0; i2 < len; i2++)
    if (!tab2[i2])
    return i2
  return -1
}


@Field Scanner scanner = new Scanner(System.in)
int len = Integer.parseInt(scanner.nextLine())
System.out.printf("%s\n", len);
int[] tab = read_int_line()
System.out.printf("%s\n", result(len, tab));

