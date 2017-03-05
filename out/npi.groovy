import groovy.transform.Field
import java.util.*

boolean is_number(char c)
{
  return (0+c) <= (0+(char)'9') && (0+c) >= (0+(char)'0')
}
/*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/
int npi0(char[] str, int len)
{
  int[] stack = new int[len]
  for (int i = 0; i < len; i++)
      stack[i] = 0
  int ptrStack = 0
  int ptrStr = 0
  while (ptrStr < len)
      if (str[ptrStr] == (char)' ')
          ptrStr++
      else if (is_number(str[ptrStr]))
      {
          int num = 0
          while (str[ptrStr] != (char)' ')
          {
              num = num * 10 + (0+str[ptrStr]) - (0+(char)'0')
              ptrStr++
          }
          stack[ptrStack] = num
          ptrStack++
      }
      else if (str[ptrStr] == (char)'+')
      {
          stack[ptrStack - 2] += stack[ptrStack - 1]
          ptrStack--
          ptrStr++
      }
  return stack[0]
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
char[] tab = new char[len]
for (int i = 0; i < len; i++)
{
    char tmp = (char)0
    tmp = scanner.findWithinHorizon(".", 1).charAt(0)
    tab[i] = tmp
}
int result = npi0(tab, len)
print(result)

