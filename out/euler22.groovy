import groovy.transform.Field
import java.util.*

int score()
{
  scanner.findWithinHorizon("[\n\r ]*", 1)
  int len
  if (scanner.hasNext("^-")) {
    scanner.next("^-")
    len = scanner.nextInt()
  } else {
    len = scanner.nextInt()
  }
  scanner.findWithinHorizon("[\n\r ]*", 1)
  int sum = 0
  for (int i = 1; i <= len; i++)
  {
      char c = scanner.findWithinHorizon(".", 1).charAt(0)
      sum += (0+c) - (0+(char)'A') + 1
      // 		print c print " " print sum print " " 
      
  }
  return sum
}


@Field Scanner scanner = new Scanner(System.in)
int sum = 0
int n
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  n = scanner.nextInt()
} else {
  n = scanner.nextInt()
}
for (int i = 1; i <= n; i++)
    sum += i * score()
System.out.printf("%d\n", sum)

