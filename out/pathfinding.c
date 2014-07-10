#include<stdio.h>
#include<stdlib.h>

int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int min3(int a, int b, int c){
  return min2(min2(a, b), c);
}

int min4(int a, int b, int c, int d){
  int f = min2(a, b);
  int g = c;
  int h = d;
  int e = min2(min2(f, g), h);
  return e;
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
    int l = val1;
    int m = val2;
    int n = val3;
    int o = val4;
    int p = min2(l, m);
    int q = n;
    int r = o;
    int s = min2(min2(p, q), r);
    int k = s;
    int out_ = 1 + k;
    cache[posY][posX] = out_;
    return out_;
  }
}

int pathfind(char** tab, int x, int y){
  int* *cache = malloc( y * sizeof(int*));
  {
    int i;
    for (i = 0 ; i < y; i++)
    {
      int *tmp = malloc( x * sizeof(int));
      {
        int j;
        for (j = 0 ; j < x; j++)
          tmp[j] = -1;
      }
      cache[i] = tmp;
    }
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}

int main(void){
  int x = 0;
  int y = 0;
  scanf("%d %d ", &x, &y);
  char* *tab = malloc( y * sizeof(char*));
  {
    int i;
    for (i = 0 ; i < y; i++)
    {
      char *tab2 = malloc( x * sizeof(char));
      {
        int j;
        for (j = 0 ; j < x; j++)
        {
          char tmp = '\000';
          scanf("%c", &tmp);
          tab2[j] = tmp;
        }
      }
      scanf(" ");
      tab[i] = tab2;
    }
  }
  int result = pathfind(tab, x, y);
  printf("%d", result);
  return 0;
}


