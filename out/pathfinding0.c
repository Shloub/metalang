#include <stdio.h>
#include <stdlib.h>

int min2_(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int pathfind_aux(int** cache, char** tab, int x, int y, int posX, int posY){
  if (posX == x - 1 && posY == y - 1)
    return 0;
  else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
    return x * y * 10;
  else if (tab[posY][posX] == '#')
    return x * y * 10;
  else if (cache[posY][posX] != -1)
    return cache[posY][posX];
  else
  {
    cache[posY][posX] = x * y * 10;
    int val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
    int val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
    int val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
    int val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
    int out0 = 1 + min2_(min2_(min2_(val1, val2), val3), val4);
    cache[posY][posX] = out0;
    return out0;
  }
}

int pathfind(char** tab, int x, int y){
  int i, j;
  int* *cache = malloc( y * sizeof(int*));
  for (i = 0 ; i < y; i++)
  {
    int *tmp = malloc( x * sizeof(int));
    for (j = 0 ; j < x; j++)
    {
      printf("%c", tab[i][j]);
      tmp[j] = -1;
    }
    printf("\n");
    cache[i] = tmp;
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}

int main(void){
  int bg, bi, y, x;
  scanf("%d %d ", &x, &y);
  printf("%d %d\n", x, y);
  char* *bf = malloc( y * sizeof(char*));
  for (bg = 0 ; bg < y; bg++)
  {
    char *bk = malloc( x * sizeof(char));
    for (bi = 0 ; bi < x; bi++)
      scanf("%c", &bk[bi]);
    scanf(" ");
    bf[bg] = bk;
  }
  char** tab = bf;
  int result = pathfind(tab, x, y);
  printf("%d", result);
  return 0;
}


