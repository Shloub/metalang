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
  int a = 10001;
  int *t = malloc( a * sizeof(int));
  {
    int i;
    for (i = 0 ; i < a; i++)
      t[i] = 2;
  }
  int b = find(3, t, 1, 10001);
  printf("%d\n", b);
  return 0;
}


