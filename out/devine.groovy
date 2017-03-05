import groovy.transform.Field
import java.util.*

boolean devine0(int nombre, int[] tab, int len)
{
  int min0 = tab[0]
  int max0 = tab[1]
  for (int i = 2; i < len; i++)
  {
      if (tab[i] > max0 || tab[i] < min0)
          return false
      if (tab[i] < nombre)
          min0 = tab[i]
      if (tab[i] > nombre)
          max0 = tab[i]
      if (tab[i] == nombre && len != i + 1)
          return false
  }
  return true
}
@Field Scanner scanner = new Scanner(System.in)
int nombre
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  nombre = scanner.nextInt()
} else {
  nombre = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
int len
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  len = scanner.nextInt()
} else {
  len = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
int[] tab = new int[len]
for (int i = 0; i < len; i++)
{
    int tmp
    if (scanner.hasNext("^-")) {
      scanner.next("^-")
      tmp = scanner.nextInt()
    } else {
      tmp = scanner.nextInt()
    }
    scanner.findWithinHorizon("[\n\r ]*", 1)
    tab[i] = tmp
}
if (devine0(nombre, tab, len))
    print("True")
else
    print("False")

