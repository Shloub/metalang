#include <stdio.h>
#include <stdlib.h>

int exp0(int a, int e){
  int i;
  int o = 1;
  for (i = 1 ; i <= e; i++)
    o *= a;
  return o;
}

int e(int* t, int n){
  int i;
  for (i = 1 ; i <= 8; i++)
    if (n >= t[i] * i)
    n -= t[i] * i;
  else
  {
    int nombre = exp0(10, i - 1) + n / i;
    int chiffre = i - 1 - n % i;
    return (nombre / exp0(10, chiffre)) % 10;
  }
  return -1;
}

int main(void){
  int l, k2, j2, k, j, i2, i;
  int *t = malloc( 9 * sizeof(int));
  for (i = 0 ; i < 9; i++)
    t[i] = exp0(10, i) - exp0(10, i - 1);
  for (i2 = 1 ; i2 <= 8; i2++)
  {
    printf("%d => %d\n", i2, t[i2]);
  }
  for (j = 0 ; j <= 80; j++)
    printf("%d", e(t, j));
  printf("\n");
  for (k = 1 ; k <= 50; k++)
    printf("%d", k);
  printf("\n");
  for (j2 = 169 ; j2 <= 220; j2++)
    printf("%d", e(t, j2));
  printf("\n");
  for (k2 = 90 ; k2 <= 110; k2++)
    printf("%d", k2);
  printf("\n");
  int out0 = 1;
  for (l = 0 ; l <= 6; l++)
  {
    int puiss = exp0(10, l);
    int v = e(t, puiss - 1);
    out0 *= v;
    printf("10^%d=%d v=%d\n", l, puiss, v);
  }
  printf("%d\n", out0);
  return 0;
}


