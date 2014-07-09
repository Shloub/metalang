#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int pgcd(int a, int b){
  int c = min2(a, b);
  int d = max2(a, b);
  int reste = d % c;
  if (reste == 0)
    return c;
  else
    return pgcd(c, reste);
}

int main(void){
  int top = 1;
  int bottom = 1;
  {
    int i;
    for (i = 1 ; i <= 9; i++)
      {
      int j;
      for (j = 1 ; j <= 9; j++)
        {
        int k;
        for (k = 1 ; k <= 9; k++)
          if (i != j && j != k)
        {
          int a = i * 10 + j;
          int b = j * 10 + k;
          if (a * k == i * b)
          {
            printf("%d/%d\n", a, b);
            top *= a;
            bottom *= b;
          }
        }
      }
    }
  }
  printf("%d/%d\n", top, bottom);
  int p = pgcd(top, bottom);
  printf("pgcd=%d\n%d\n", p, bottom / p);
  return 0;
}


