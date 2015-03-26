import groovy.transform.Field
import java.util.*

int go0(int[] tab, int a, int b)
{
  int m = (int)((a + b) / 2)
  if (a == m)
  {
    if (tab[a] == m)
      return b
    else
      return a
  }
  int i = a
  int j = b
  while (i < j)
  {
    int e = tab[i]
    if (e < m)
      i ++;
    else
    {
      j --;
      tab[i] = tab[j]
      tab[j] = e
    }
  }
  if (i < m)
    return go0(tab, a, m)
  else
    return go0(tab, m, b)
}

int plus_petit0(int[] tab, int len)
{
  return go0(tab, 0, len)
}


@Field Scanner scanner = new Scanner(System.in)
int len = 0
if (scanner.hasNext("^-")){
  scanner.next("^-");
  len = -scanner.nextInt();
}else{
  len = scanner.nextInt();
}
scanner.findWithinHorizon("[\n\r ]*", 1)
int[] tab = new int[len]
for (int i = 0 ; i < len; i++)
{
  int tmp = 0
  if (scanner.hasNext("^-")){
    scanner.next("^-");
    tmp = -scanner.nextInt();
  }else{
    tmp = scanner.nextInt();
  }
  scanner.findWithinHorizon("[\n\r ]*", 1)
  tab[i] = tmp
}
print(plus_petit0(tab, len))

