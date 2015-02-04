#include <stdio.h>
#include <stdlib.h>

int max2_(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int find(int n, int** m, int x, int y, int dx, int dy){
  if (x < 0 || x == 20 || y < 0 || y == 20)
    return -1;
  else if (n == 0)
    return 1;
  else
    return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);
}

typedef struct tuple_int_int {
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
} tuple_int_int;

int main(void){
  int j, x, y, o, q, i;
  struct tuple_int_int * *directions = malloc( 8 * sizeof(struct tuple_int_int *));
  for (i = 0 ; i < 8; i++)
    if (i == 0)
  {
    struct tuple_int_int * bh = malloc (sizeof(bh) );
    bh->tuple_int_int_field_0=0;
    bh->tuple_int_int_field_1=1;
    directions[i] = bh;
  }
  else if (i == 1)
  {
    struct tuple_int_int * bg = malloc (sizeof(bg) );
    bg->tuple_int_int_field_0=1;
    bg->tuple_int_int_field_1=0;
    directions[i] = bg;
  }
  else if (i == 2)
  {
    struct tuple_int_int * bf = malloc (sizeof(bf) );
    bf->tuple_int_int_field_0=0;
    bf->tuple_int_int_field_1=-1;
    directions[i] = bf;
  }
  else if (i == 3)
  {
    struct tuple_int_int * be = malloc (sizeof(be) );
    be->tuple_int_int_field_0=-1;
    be->tuple_int_int_field_1=0;
    directions[i] = be;
  }
  else if (i == 4)
  {
    struct tuple_int_int * bd = malloc (sizeof(bd) );
    bd->tuple_int_int_field_0=1;
    bd->tuple_int_int_field_1=1;
    directions[i] = bd;
  }
  else if (i == 5)
  {
    struct tuple_int_int * bc = malloc (sizeof(bc) );
    bc->tuple_int_int_field_0=1;
    bc->tuple_int_int_field_1=-1;
    directions[i] = bc;
  }
  else if (i == 6)
  {
    struct tuple_int_int * bb = malloc (sizeof(bb) );
    bb->tuple_int_int_field_0=-1;
    bb->tuple_int_int_field_1=1;
    directions[i] = bb;
  }
  else
  {
    struct tuple_int_int * ba = malloc (sizeof(ba) );
    ba->tuple_int_int_field_0=-1;
    ba->tuple_int_int_field_1=-1;
    directions[i] = ba;
  }
  int max0 = 0;
  int h = 20;
  int* *m = malloc( 20 * sizeof(int*));
  for (o = 0 ; o < 20; o++)
  {
    int *s = malloc( h * sizeof(int));
    for (q = 0 ; q < h; q++)
    {
      scanf("%d ", &s[q]);
    }
    m[o] = s;
  }
  for (j = 0 ; j <= 7; j++)
  {
    struct tuple_int_int * w = directions[j];
    int dx = w->tuple_int_int_field_0;
    int dy = w->tuple_int_int_field_1;
    for (x = 0 ; x <= 19; x++)
      for (y = 0 ; y <= 19; y++)
        max0 = max2_(max0, find(4, m, x, y, dx, dy));
  }
  printf("%d\n", max0);
  return 0;
}


