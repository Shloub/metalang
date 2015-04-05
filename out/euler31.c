#include <stdio.h>
#include <stdlib.h>

int result(int sum, int* t, int maxIndex, int** cache){
  int i;
  if (cache[sum][maxIndex] != 0)
    return cache[sum][maxIndex];
  else if (sum == 0 || maxIndex == 0)
    return 1;
  else
  {
    int out0 = 0;
    int div = sum / t[maxIndex];
    for (i = 0 ; i <= div; i++)
      out0 += result(sum - i * t[maxIndex], t, maxIndex - 1, cache);
    cache[sum][maxIndex] = out0;
    return out0;
  }
}

int main(void){
  int j, k, i;
  int *t = calloc( 8 , sizeof(int));
  for (i = 0 ; i < 8; i++)
    t[i] = 0;
  t[0] = 1;
  t[1] = 2;
  t[2] = 5;
  t[3] = 10;
  t[4] = 20;
  t[5] = 50;
  t[6] = 100;
  t[7] = 200;
  int* *cache = calloc( 201 , sizeof(int*));
  for (j = 0 ; j < 201; j++)
  {
    int *o = calloc( 8 , sizeof(int));
    for (k = 0 ; k < 8; k++)
      o[k] = 0;
    cache[j] = o;
  }
  printf("%d", result(200, t, 7, cache));
  return 0;
}


