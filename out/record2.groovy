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

int result(Toto t)
{
  t.blah += 1
  return t.foo + t.blah * t.bar + t.bar * t.foo
}


@Field Scanner scanner = new Scanner(System.in)
Toto t = mktoto(4)
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  t.bar = -scanner.nextInt()
}else{
  t.bar = scanner.nextInt()
}
scanner.findWithinHorizon("[\n\r ]*", 1)
if (scanner.hasNext("^-")) {
  scanner.next("^-")
  t.blah = -scanner.nextInt()
}else{
  t.blah = scanner.nextInt()
}
print(result(t))

