#include<stdio.h>
#include<stdlib.h>

/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
*/
int find0(int len, int** tab, int** cache, int x, int y){
  /*
	Cette fonction est récursive
	*/
  if (y == len - 1)
    return tab[y][x];
  else if (x > y)
    return 100000;
  else if (cache[y][x] != 0)
    return cache[y][x];
  int result = 0;
  int out0 = find0(len, tab, cache, x, y + 1);
  int out1 = find0(len, tab, cache, x + 1, y + 1);
  if (out0 < out1)
    result = out0 + tab[y][x];
  else
    result = out1 + tab[y][x];
  cache[y][y] = result;
  return result;
}

int find_(int len, int** tab){
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
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c");
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
          scanf("%d", &tmp);
          scanf("%*[ \t\r\n]c");
          tab2[j] = tmp;
        }
      }
      tab[i] = tab2;
    }
  }
  int c = find_(len, tab);
  printf("%d", c);
  {
    int k;
    for (k = 0 ; k < len; k++)
    {
      {
        int l;
        for (l = 0 ; l <= k; l++)
        {
          int d = tab[k][l];
          printf("%d", d);
        }
      }
      printf("\n");
    }
  }
  return 0;
}


