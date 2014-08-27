#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
on le retrouve ici : http://projecteuler.net/problem=18
*/
int find0(int len, int** tab, int** cache, int x, int y){
  /*
	Cette fonction est récursive
	*/
  if (y == len - 1)
    return tab[y][x];
  else if (x > y)
    return -10000;
  else if (cache[y][x] != 0)
    return cache[y][x];
  int result = 0;
  int out0 = find0(len, tab, cache, x, y + 1);
  int out1 = find0(len, tab, cache, x + 1, y + 1);
  if (out0 > out1)
    result = out0 + tab[y][x];
  else
    result = out1 + tab[y][x];
  cache[y][x] = result;
  return result;
}

int find(int len, int** tab){
  int i, j;
  int* *tab2 = malloc( len * sizeof(int*));
  for (i = 0 ; i < len; i++)
  {
    int *tab3 = malloc( (i + 1) * sizeof(int));
    for (j = 0 ; j < i + 1; j++)
      tab3[j] = 0;
    tab2[i] = tab3;
  }
  return find0(len, tab, tab2, 0, 0);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int k, l, i, j;
  int len = 0;
  scanf("%d ", &len);
  int* *tab = malloc( len * sizeof(int*));
  for (i = 0 ; i < len; i++)
  {
    int *tab2 = malloc( (i + 1) * sizeof(int));
    for (j = 0 ; j < i + 1; j++)
    {
      int tmp = 0;
      scanf("%d ", &tmp);
      tab2[j] = tmp;
    }
    tab[i] = tab2;
  }
  printf("%d\n", find(len, tab));
  for (k = 0 ; k < len; k++)
  {
    for (l = 0 ; l <= k; l++)
    {
      printf("%d ", tab[k][l]);
    }
    printf("\n");
  }
  [pool drain];
  return 0;
}


