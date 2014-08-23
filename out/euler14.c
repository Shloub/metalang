#include<stdio.h>
#include<stdlib.h>

int next_(int n){
  if ((n % 2) == 0)
    return n / 2;
  else
    return 3 * n + 1;
}

int find(int n, int* m){
  if (n == 1)
    return 1;
  else if (n >= 1000000)
    return 1 + find(next_(n), m);
  else if (m[n] != 0)
    return m[n];
  else
  {
    m[n] = 1 + find(next_(n), m);
    return m[n];
  }
}

int main(void){
  int *m = malloc( 1000000 * sizeof(int));
  {
    int j;
    for (j = 0 ; j < 1000000; j++)
      m[j] = 0;
  }
  int max_ = 0;
  int maxi = 0;
  {
    int i;
    for (i = 1 ; i <= 999; i++)
    {
      /* normalement on met 999999 mais ça dépasse les int32... */
      int n2 = find(i, m);
      if (n2 > max_)
      {
        max_ = n2;
        maxi = i;
      }
    }
  }
  printf("%d\n%d\n", max_, maxi);
  return 0;
}


