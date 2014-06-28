#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int pathfind_aux(int* cache, int* tab, int len, int pos){
  if (pos >= len - 1)
    return 0;
  else if (cache[pos] != -1)
    return cache[pos];
  else
  {
    cache[pos] = len * 2;
    int posval = pathfind_aux(cache, tab, len, tab[pos]);
    int oneval = pathfind_aux(cache, tab, len, pos + 1);
    int out_ = 0;
    if (posval < oneval)
      out_ = 1 + posval;
    else
      out_ = 1 + oneval;
    cache[pos] = out_;
    return out_;
  }
}

int pathfind(int* tab, int len){
  int *cache = malloc( len * sizeof(int));
  {
    int i;
    for (i = 0 ; i < len; i++)
      cache[i] = -1;
  }
  return pathfind_aux(cache, tab, len, 0);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
  int *tab = malloc( len * sizeof(int));
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int tmp = 0;
      scanf("%d", &tmp);
      scanf("%*[ \t\r\n]c");
      tab[i] = tmp;
    }
  }
  int result = pathfind(tab, len);
  printf("%d", result);
  [pool drain];
  return 0;
}


