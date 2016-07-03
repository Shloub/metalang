import java.util.*

int pgcd(int a, int b)
{
  int c = Math.min(a, b)
  int d = Math.max(a, b)
  int reste = d % c
  if (reste == 0)
      return c
  else
      return pgcd(c, reste)
}



int top = 1
int bottom = 1
for (int i = 1; i < 10; i += 1)
    for (int j = 1; j < 10; j += 1)
        for (int k = 1; k < 10; k += 1)
            if (i != j && j != k)
            {
                int a = i * 10 + j
                int b = j * 10 + k
                if (a * k == i * b)
                {
                    System.out.printf("%d/%d\n", a, b)
                    top *= a
                    bottom *= b
                }
            }
System.out.printf("%d/%d\n", top, bottom)
int p = pgcd(top, bottom)
System.out.printf("pgcd=%d\n%d\n", p, bottom.intdiv(p))

