import groovy.transform.Field
import java.util.*

/*
Ce test effectue un rot13 sur une chaine lue en entrée
*/


@Field Scanner scanner = new Scanner(System.in)
int strlen
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  strlen = scanner.nextInt()
} else {
  strlen = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
char[] tab4 = new char[strlen]
for (int toto = 0; toto < strlen; toto++)
{
    char tmpc = scanner.findWithinHorizon(".", 1).charAt(0)
    int c = (0+tmpc)
    if (tmpc != (char)' ')
        c = (c - (0+(char)'a') + 13) % 26 + (0+(char)'a')
    tab4[toto] = (char)(c)
}
for (int j = 0; j < strlen; j++)
    print(tab4[j])

