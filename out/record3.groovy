import groovy.transform.Field
import java.util.*

class Toto {
  int foo
  int bar
  int blah
}
Toto mktoto(int v1)
{
  Toto t = new Toto()
  t.foo = v1
  t.bar = 0
  t.blah = 0
  return t
}

int result(Toto[] t, int len)
{
  int out0 = 0
  for (int j = 0; j < len; j += 1)
  {
      t[j].blah += 1
      out0 = out0 + t[j].foo + t[j].blah * t[j].bar + t[j].bar * t[j].foo
  }
  return out0
}


@Field Scanner scanner = new Scanner(System.in)
Toto[] t = new Toto[4]
for (int i = 0; i < 4; i += 1)
    t[i] = mktoto(i)
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  t[0].bar = -scanner.nextInt()
}else{
  t[0].bar = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  t[1].blah = -scanner.nextInt()
}else{
  t[1].blah = scanner.nextInt()
}
int titi = result(t, 4)
System.out.printf("%d%d", titi, t[2].blah)

