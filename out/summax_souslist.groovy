import groovy.transform.Field
import java.util.*

int summax(int[] lst, int len)
{
  int current = 0
  int max0 = 0
  for (int i = 0; i < len; i += 1)
  {
      current += lst[i]
      if (current < 0)
          current = 0
      if (max0 < current)
          max0 = current
  }
  return max0
}


@Field Scanner scanner = new Scanner(System.in)
int len = 0
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  len = -scanner.nextInt()
}else{
  len = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
int[] tab = new int[len]
for (int i = 0; i < len; i += 1)
{
    int tmp = 0
    if (scanner.hasNext("^-")) {
      scanner.next("^-")
      tmp = -scanner.nextInt()
    }else{
      tmp = scanner.nextInt()
    }
    scanner.findWithinHorizon("[\n\r ]*", 1)
    tab[i] = tmp
}
int result = summax(tab, len)
print(result)

