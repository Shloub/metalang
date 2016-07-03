import java.util.*

class Toto {
  String s
  int v
}
String idstring(String s)
{
  return s
}

void printstring(String s)
{
  System.out.printf("%s\n", idstring(s))
}

void print_toto(Toto t)
{
  System.out.printf("%s = %d\n", t.s, t.v)
}



String[] tab = new String[2]
for (int i = 0; i < 2; i++)
    tab[i] = idstring("chaine de test")
for (int j = 0; j < 2; j++)
    printstring(idstring(tab[j]))
Toto a = new Toto()
a.s = "one"
a.v = 1
print_toto(a)

