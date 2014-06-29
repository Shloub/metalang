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
  int* *tab2 = malloc( len * sizeof(int*));
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int a = i + 1;
      int *tab3 = malloc( a * sizeof(int));
      {
        int j;
        for (j = 0 ; j < a; j++)
          tab3[j] = 0;
      }
      tab2[i] = tab3;
    }
  }
  return find0(len, tab, tab2, 0, 0);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int len = 0;
  scanf("%d ", &len);
  int* *tab = malloc( len * sizeof(int*));
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      int b = i + 1;
      int *tab2 = malloc( b * sizeof(int));
      {
        int j;
        for (j = 0 ; j < b; j++)
        {
          int tmp = 0;
          scanf("%d ", &tmp);
          tab2[j] = tmp;
        }
      }
      tab[i] = tab2;
    }
  }
  int c = find(len, tab);
  printf("%d\n", c);
  {
    int k;
    for (k = 0 ; k < len; k++)
    {
      {
        int l;
        for (l = 0 ; l <= k; l++)
        {
          int d = tab[k][l];
          printf("%d ", d);
        }
      }
      printf("\n");
    }
  }
  [pool drain];
  return 0;
}


