#include<stdio.h>
#include<stdlib.h>

int go(int* tab, int a, int b){
  int m = (a + b) / 2;
  if (a == m)
    if (tab[a] == m)
    return b;
  else
    return a;
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
    return go(tab, a, m);
  else
    return go(tab, m, b);
}

int plus_petit_(int* tab, int len){
  return go(tab, 0, len);
}

int main(void){
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
  int c = plus_petit_(tab, len);
  printf("%d", c);
  return 0;
}


