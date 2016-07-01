import groovy.transform.Field
import java.util.*

/*
La suite de fibonaci
*/
int fibo0(int a, int b, int i)
{
  int out0 = 0
  int a2 = a
  int b2 = b
  for (int j = 0; j <= i + 1; j += 1)
  {
      out0 += a2
      int tmp = b2
      b2 += a2
      a2 = tmp
  }
  return out0
}


@Field Scanner scanner = new Scanner(System.in)
int a = 0
int b = 0
int i = 0
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  a = -scanner.nextInt()
}else{
  a = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  b = -scanner.nextInt()
}else{
  b = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  i = -scanner.nextInt()
}else{
  i = scanner.nextInt()
}
print(fibo0(a, b, i))

