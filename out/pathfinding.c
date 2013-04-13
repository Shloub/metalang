#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

int min2(int a, int b){
  if (a < b)
  {
    return a;
  }
  return b;
}

int min3(int a, int b, int c){
  return min2(min2(a, b), c);
}

int min4(int a, int b, int c, int d){
  return min3(min2(a, b), c, d);
}

int pathfind_aux(int** cache, char** tab, int x, int y, int posX, int posY){
  if ((posX == (x - 1)) && (posY == (y - 1)))
  {
    return 0;
  }
  else if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
  {
    return (x * y) * 10;
  }
  else if (tab[posY][posX] == '#')
  {
    return (x * y) * 10;
  }
  else if (cache[posY][posX] != (-1))
  {
    return cache[posY][posX];
  }
  else
  {
    cache[posY][posX] = (x * y) * 10;
    int val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
    int val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
    int val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
    int val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
    int out_ = 1 + min4(val1, val2, val3, val4);
    cache[posY][posX] = out_;
    return out_;
  }
}

int pathfind(char** tab, int x, int y){
  int* *cache = malloc( (y) * sizeof(int*) + sizeof(int));
  ((int*)cache)[0]=y;
  cache=(int**)( ((int*)cache)+1);
  {
    int i;
    for (i = 0 ; i <= y - 1; i++)
    {
      int *tmp = malloc( (x) * sizeof(int) + sizeof(int));
      ((int*)tmp)[0]=x;
      tmp=(int*)( ((int*)tmp)+1);
      {
        int j;
        for (j = 0 ; j <= x - 1; j++)
        {
          tmp[j] = -1;
        }
      }
      cache[i] = tmp;
    }
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}

int main(void){
  int x = 0;
  int y = 0;
  scanf("%d", &x);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &y);
  scanf("%*[ \t\r\n]c", 0);
  char* *tab = malloc( (y) * sizeof(char*) + sizeof(int));
  ((int*)tab)[0]=y;
  tab=(char**)( ((int*)tab)+1);
  {
    int i;
    for (i = 0 ; i <= y - 1; i++)
    {
      char *tab2 = malloc( (x) * sizeof(char) + sizeof(int));
      ((int*)tab2)[0]=x;
      tab2=(char*)( ((int*)tab2)+1);
      {
        int j;
        for (j = 0 ; j <= x - 1; j++)
        {
          char tmp = '\000';
          scanf("%c", &tmp);
          tab2[j] = tmp;
        }
      }
      scanf("%*[ \t\r\n]c", 0);
      tab[i] = tab2;
    }
  }
  int result = pathfind(tab, x, y);
  printf("%d", result);
  return 0;
}


