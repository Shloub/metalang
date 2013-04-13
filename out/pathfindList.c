#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

int pathfind_aux(int* cache, int* tab, int len, int pos){
  if (pos >= (len - 1))
  {
    return 0;
  }
  else if (cache[pos] != (-1))
  {
    return cache[pos];
  }
  else
  {
    cache[pos] = len * 2;
    int posval = pathfind_aux(cache, tab, len, tab[pos]);
    int oneval = pathfind_aux(cache, tab, len, pos + 1);
    int out_ = 0;
    if (posval < oneval)
    {
      out_ = 1 + posval;
    }
    else
    {
      out_ = 1 + oneval;
    }
    cache[pos] = out_;
    return out_;
  }
}

int pathfind(int* tab, int len){
  int *cache = malloc( (len) * sizeof(int) + sizeof(int));
  ((int*)cache)[0]=len;
  cache=(int*)( ((int*)cache)+1);
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      cache[i] = -1;
    }
  }
  return pathfind_aux(cache, tab, len, 0);
}

int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  int *tab = malloc( (len) * sizeof(int) + sizeof(int));
  ((int*)tab)[0]=len;
  tab=(int*)( ((int*)tab)+1);
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      int tmp = 0;
      scanf("%d", &tmp);
      scanf("%*[ \t\r\n]c", 0);
      tab[i] = tmp;
    }
  }
  int result = pathfind(tab, len);
  printf("%d", result);
  return 0;
}


