#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  return b;
}

int* read_int_line(int n){
  int *tab = malloc( n * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int t = 0;
      scanf("%d", &t);
      scanf("%*[ \t\r\n]c");
      tab[i] = t;
    }
  }
  return tab;
}

int** read_int_matrix(int x, int y){
  int* *tab = malloc( y * sizeof(int*));
  {
    int z;
    for (z = 0 ; z < y; z++)
    {
      scanf("%*[ \t\r\n]c");
      tab[z] = read_int_line(x);
    }
  }
  return tab;
}

int find(int n, int** m, int x, int y, int dx, int dy){
  if (x < 0 || x == 20 || y < 0 || y == 20)
    return -1;
  else if (n == 0)
    return 1;
  else
    return m[y][x] * find(n - 1, m, x + dx, y + dy, dx, dy);
}

struct tuple_int_int;
typedef struct tuple_int_int {
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
} tuple_int_int;

int main(void){
  int c = 8;
  struct tuple_int_int * *directions = malloc( c * sizeof(struct tuple_int_int *));
  {
    int i;
    for (i = 0 ; i < c; i++)
      if (i == 0)
    {
      struct tuple_int_int * p = malloc (sizeof(p) );
      p->tuple_int_int_field_0=0;
      p->tuple_int_int_field_1=1;
      directions[i] = p;
    }
    else if (i == 1)
    {
      struct tuple_int_int * o = malloc (sizeof(o) );
      o->tuple_int_int_field_0=1;
      o->tuple_int_int_field_1=0;
      directions[i] = o;
    }
    else if (i == 2)
    {
      struct tuple_int_int * l = malloc (sizeof(l) );
      l->tuple_int_int_field_0=0;
      l->tuple_int_int_field_1=-1;
      directions[i] = l;
    }
    else if (i == 3)
    {
      struct tuple_int_int * k = malloc (sizeof(k) );
      k->tuple_int_int_field_0=-1;
      k->tuple_int_int_field_1=0;
      directions[i] = k;
    }
    else if (i == 4)
    {
      struct tuple_int_int * h = malloc (sizeof(h) );
      h->tuple_int_int_field_0=1;
      h->tuple_int_int_field_1=1;
      directions[i] = h;
    }
    else if (i == 5)
    {
      struct tuple_int_int * g = malloc (sizeof(g) );
      g->tuple_int_int_field_0=1;
      g->tuple_int_int_field_1=-1;
      directions[i] = g;
    }
    else if (i == 6)
    {
      struct tuple_int_int * f = malloc (sizeof(f) );
      f->tuple_int_int_field_0=-1;
      f->tuple_int_int_field_1=1;
      directions[i] = f;
    }
    else
    {
      struct tuple_int_int * e = malloc (sizeof(e) );
      e->tuple_int_int_field_0=-1;
      e->tuple_int_int_field_1=-1;
      directions[i] = e;
    }
  }
  int max_ = 0;
  int** m = read_int_matrix(20, 20);
  {
    int j;
    for (j = 0 ; j <= 7; j++)
    {
      struct tuple_int_int * d = directions[j];
      int dx = d->tuple_int_int_field_0;
      int dy = d->tuple_int_int_field_1;
      {
        int x;
        for (x = 0 ; x <= 19; x++)
          {
          int y;
          for (y = 0 ; y <= 19; y++)
            max_ = max2(max_, find(4, m, x, y, dx, dy));
        }
      }
    }
  }
  printf("%d\n", max_);
  return 0;
}


