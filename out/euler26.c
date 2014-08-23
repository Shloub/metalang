#include<stdio.h>
#include<stdlib.h>

int periode(int* restes, int len, int a, int b){
  while (a != 0)
  {
    int chiffre = a / b;
    int reste = a % b;
    {
      int i;
      for (i = 0 ; i < len; i++)
        if (restes[i] == reste)
        return len - i;
    }
    restes[len] = reste;
    len ++;
    a = reste * 10;
  }
  return 0;
}

int main(void){
  int *t = malloc( 1000 * sizeof(int));
  {
    int j;
    for (j = 0 ; j < 1000; j++)
      t[j] = 0;
  }
  int m = 0;
  int mi = 0;
  {
    int i;
    for (i = 1 ; i <= 1000; i++)
    {
      int p = periode(t, 0, 1, i);
      if (p > m)
      {
        mi = i;
        m = p;
      }
    }
  }
  printf("%d\n%d\n", mi, m);
  return 0;
}


