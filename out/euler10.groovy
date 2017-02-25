import java.util.*

int eratostene(int[] t, int max0)
{
  int sum = 0
  for (int i = 2; i < max0; i++)
      if (t[i] == i)
      {
          sum += i
          if (max0.intdiv(i) > i)
          {
              int j = i * i
              while (j < max0 && j > 0)
              {
                  t[j] = 0
                  j += i
              }
          }
      }
  return sum
}


int n = 100000
//  normalement on met 2000 000 mais là on se tape des int overflow dans plein de langages 
int[] t = new int[n]
for (int i = 0; i < n; i++)
    t[i] = i
t[1] = 0
System.out.printf("%d\n", eratostene(t, n))

