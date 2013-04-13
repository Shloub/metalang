#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

/* Ce code a été généré par metalang
   Il gère les entrées sorties pour un programme dynamique classique
   dans les épreuves de prologin
*/
int find0(int len, int** tab, int** cache, int x, int y){
  /*
	Cette fonction est récursive
	*/
  if (y == (len - 1))
  {
    return tab[y][x];
  }
  else if (x > y)
  {
    return 100000;
  }
  else if (cache[y][x] != 0)
  {
    return cache[y][x];
  }
  int result = 0;
  int out0 = find0(len, tab, cache, x, y + 1);
  int out1 = find0(len, tab, cache, x + 1, y + 1);
  if (out0 < out1)
  {
    result = out0 + tab[y][x];
  }
  else
  {
    result = out1 + tab[y][x];
  }
  cache[y][y] = result;
  return result;
}

int find(int len, int** tab){
  int* *tab2 = malloc( (len) * sizeof(int*) + sizeof(int));
  ((int*)tab2)[0]=len;
  tab2=(int**)( ((int*)tab2)+1);
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      int a = i + 1;
      int *tab3 = malloc( (a) * sizeof(int) + sizeof(int));
      ((int*)tab3)[0]=a;
      tab3=(int*)( ((int*)tab3)+1);
      {
        int j;
        for (j = 0 ; j <= a - 1; j++)
        {
          tab3[j] = 0;
        }
      }
      tab2[i] = tab3;
    }
  }
  return find0(len, tab, tab2, 0, 0);
}

int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  int* *tab = malloc( (len) * sizeof(int*) + sizeof(int));
  ((int*)tab)[0]=len;
  tab=(int**)( ((int*)tab)+1);
  {
    int i;
    for (i = 0 ; i <= len - 1; i++)
    {
      int b = i + 1;
      int *tab2 = malloc( (b) * sizeof(int) + sizeof(int));
      ((int*)tab2)[0]=b;
      tab2=(int*)( ((int*)tab2)+1);
      {
        int j;
        for (j = 0 ; j <= b - 1; j++)
        {
          int tmp = 0;
          scanf("%d", &tmp);
          scanf("%*[ \t\r\n]c", 0);
          tab2[j] = tmp;
        }
      }
      tab[i] = tab2;
    }
  }
  int c = find(len, tab);
  printf("%d", c);
  {
    int d;
    for (d = 0 ; d <= (count(tab)) - 1; d++)
    {
      int* e = tab[d];
      {
        int f;
        for (f = 0 ; f <= (count(e)) - 1; f++)
        {
          printf("%d", e[f]);
        }
      }
    }
  }
  return 0;
}


