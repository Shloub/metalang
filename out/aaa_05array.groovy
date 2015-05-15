import java.util.*

boolean[] id(boolean[] b)
{
  return b
}

void g(boolean[] t, int index)
{
  t[index] = false
}



int j = 0
boolean[] a = new boolean[5]
for (int i = 0 ; i < 5; i++)
{
  print(i)
  j += i;
  a[i] = i % 2 == 0
}
System.out.printf("%s ", j);
boolean c = a[0]
if (c)
  print("True")
else
  print("False")
print("\n")
g(id(a), 0)
boolean d = a[0]
if (d)
  print("True")
else
  print("False")
print("\n")

