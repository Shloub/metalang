#include<stdio.h>
#include<stdlib.h>

int divisible(int n, int* t, int size){
  {
    int i;
    for (i = 0 ; i < size; i++)
      if ((n % t[i]) == 0)
      return 1;
  }
  return 0;
}

int find(int n, int* t, int used, int nth){
  while (used != nth)
    if (divisible(n, t, used))
    n ++;
  else
  {
    t[used] = n;
    n ++;
    used ++;
  }
  return t[used - 1];
}

int main(void){
  int n = 10001;
  int *t = malloc( n * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n; i++)
      t[i] = 2;
  }
  int a = find(3, t, 1, n);
  printf("%d\n", a);
  return 0;
}


