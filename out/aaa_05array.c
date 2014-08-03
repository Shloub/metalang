#include<stdio.h>
#include<stdlib.h>

int main(void){
  int b = 5;
  int *a = malloc( b * sizeof(int));
  {
    int i;
    for (i = 0 ; i < b; i++)
    {
      printf("%d", i);
      a[i] = i * 2;
    }
  }
  return 0;
}


