#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int j, s, v, w, i, k, f;
  scanf("%d ", &f);
  int len = f;
  printf("%d=len\n", len);
  int *tab1 = malloc( len * sizeof(int));
  for (k = 0 ; k < len; k++)
  {
    scanf("%d ", &tab1[k]);
  }
  for (i = 0 ; i < len; i++)
  {
    printf("%d=>%d\n", i, tab1[i]);
  }
  scanf("%d ", &len);
  int* *tab2 = malloc( (len - 1) * sizeof(int*));
  for (s = 0 ; s < len - 1; s++)
  {
    int *ba = malloc( len * sizeof(int));
    for (v = 0 ; v < len; v++)
    {
      scanf("%d ", &w);
      ba[v] = w;
    }
    tab2[s] = ba;
  }
  for (i = 0 ; i <= len - 2; i++)
  {
    for (j = 0 ; j < len; j++)
    {
      printf("%d ", tab2[i][j]);
    }
    printf("\n");
  }
  [pool drain];
  return 0;
}


