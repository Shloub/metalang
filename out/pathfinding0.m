#import <Foundation/Foundation.h>
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

int read_int(){
  int out_ = 0;
  scanf("%d ", &out_);
  return out_;
}

char* read_char_line(int n){
  char *tab = malloc( n * sizeof(char));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      char t = '_';
      scanf("%c", &t);
      tab[i] = t;
    }
  }
  scanf(" ");
  return tab;
}

char** read_char_matrix(int x, int y){
  char* *tab = malloc( y * sizeof(char*));
  {
    int z;
    for (z = 0 ; z < y; z++)
    {
      int l = x;
      char *m = malloc( l * sizeof(char));
      {
        int o;
        for (o = 0 ; o < l; o++)
        {
          char p = '_';
          scanf("%c", &p);
          m[o] = p;
        }
      }
      scanf(" ");
      char* k = m;
      tab[z] = k;
    }
  }
  return tab;
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
    int r = val1;
    int s = val2;
    int u = val3;
    int v = val4;
    int w = min2(r, s);
    int ba = u;
    int bb = v;
    int bc = min2(min2(w, ba), bb);
    int q = bc;
    int out_ = 1 + q;
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
        {
          printf("%c", tab[i][j]);
          tmp[j] = -1;
        }
      }
      printf("\n");
      cache[i] = tmp;
    }
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int be = 0;
  scanf("%d ", &be);
  int bd = be;
  int x = bd;
  int bg = 0;
  scanf("%d ", &bg);
  int bf = bg;
  int y = bf;
  printf("%d %d\n", x, y);
  char** tab = read_char_matrix(x, y);
  int result = pathfind(tab, x, y);
  printf("%d", result);
  [pool drain];
  return 0;
}


