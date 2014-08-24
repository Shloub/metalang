#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int min2(int a, int b){
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
    int h = min2(val1, val2);
    int k = min2(min2(h, val3), val4);
    int g = k;
    int out_ = 1 + g;
    cache[posY][posX] = out_;
    return out_;
  }
}

int pathfind(char** tab, int x, int y){
  int i, j;
  int* *cache = malloc( y * sizeof(int*));
  for (i = 0 ; i < y; i++)
  {
    int *tmp = malloc( x * sizeof(int));
    for (j = 0 ; j < x; j++)
      tmp[j] = -1;
    cache[i] = tmp;
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i, j;
  int x = 0;
  int y = 0;
  scanf("%d %d ", &x, &y);
  char* *tab = malloc( y * sizeof(char*));
  for (i = 0 ; i < y; i++)
  {
    char *tab2 = malloc( x * sizeof(char));
    for (j = 0 ; j < x; j++)
    {
      char tmp = '\000';
      scanf("%c", &tmp);
      tab2[j] = tmp;
    }
    scanf(" ");
    tab[i] = tab2;
  }
  int result = pathfind(tab, x, y);
  printf("%d", result);
  [pool drain];
  return 0;
}


