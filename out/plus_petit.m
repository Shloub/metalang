#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int go_(int* tab, int a, int b){
  int m = (a + b) / 2;
  if (a == m)
  {
    if (tab[a] == m)
      return b;
    else
      return a;
  }
  int i = a;
  int j = b;
  while (i < j)
  {
    int e = tab[i];
    if (e < m)
      i ++;
    else
    {
      j --;
      tab[i] = tab[j];
      tab[j] = e;
    }
  }
  if (i < m)
    return go_(tab, a, m);
  else
    return go_(tab, m, b);
}

int plus_petit_(int* tab, int len){
  return go_(tab, 0, len);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i;
  int len = 0;
  scanf("%d ", &len);
  int *tab = malloc( len * sizeof(int));
  for (i = 0 ; i < len; i++)
  {
    int tmp = 0;
    scanf("%d ", &tmp);
    tab[i] = tmp;
  }
  printf("%d", plus_petit_(tab, len));
  [pool drain];
  return 0;
}


