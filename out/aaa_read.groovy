import groovy.transform.Field
import java.util.*

/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/

@Field Scanner scanner = new Scanner(System.in)
int len;
if (scanner.hasNext("^-")) {
  scanner.next("^-");
  len = scanner.nextInt();
} else {
  len = scanner.nextInt();
}
scanner.findWithinHorizon("[\n\r ]*", 1)
System.out.printf("%s=len\n", len);
len *= 2;
System.out.printf("len*2=%s\n", len);
len /= 2;
int[] tab = new int[len]
for (int i = 0; i < len; i++)
{
    int tmpi1;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      tmpi1 = scanner.nextInt();
    } else {
      tmpi1 = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1)
    System.out.printf("%s=>%s ", i, tmpi1);
    tab[i] = tmpi1
}
print("\n")
int[] tab2 = new int[len]
for (int i_ = 0; i_ < len; i_++)
{
    int tmpi2;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      tmpi2 = scanner.nextInt();
    } else {
      tmpi2 = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1)
    System.out.printf("%s==>%s ", i_, tmpi2);
    tab2[i_] = tmpi2
}
int strlen;
if (scanner.hasNext("^-")) {
  scanner.next("^-");
  strlen = scanner.nextInt();
} else {
  strlen = scanner.nextInt();
}
scanner.findWithinHorizon("[\n\r ]*", 1)
System.out.printf("%s=strlen\n", strlen);
char[] tab4 = new char[strlen]
for (int toto = 0; toto < strlen; toto++)
{
    char tmpc = scanner.findWithinHorizon(".", 1).charAt(0);
    int c = (0+tmpc)
    System.out.printf("%s:%s ", tmpc, c);
    if (tmpc != (char)' ')
      c = (c - (0+(char)'a') + 13) % 26 + (0+(char)'a')
    tab4[toto] = (char)(c)
}
for (int j = 0; j < strlen; j++)
  print(tab4[j])

