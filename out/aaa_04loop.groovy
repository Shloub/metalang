import java.util.*

boolean h(int i)
{
  /*  for j = i - 2 to i + 2 do
    if i % j == 5 then return true end
  end */
  int j = i - 2
  while (j <= i + 2)
  {
      if (i % j == 5)
          return true
      j += 1
  }
  return false
}



int j = 0
for (int k = 0; k <= 10; k += 1)
{
    j += k
    System.out.printf("%d\n", j)
}
int i = 4
while (i < 10)
{
    print(i)
    i += 1
    j += i
}
System.out.printf("%d%dFIN TEST\n", j, i)

