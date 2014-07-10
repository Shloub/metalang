#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int* read_int_line(int n){
  int *tab = malloc( n * sizeof(int));
  {
    int i;
    for (i = 0 ; i < n; i++)
    {
      int t = 0;
      scanf("%d ", &t);
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
      int *e = malloc( x * sizeof(int));
      {
        int f;
        for (f = 0 ; f < x; f++)
        {
          int g = 0;
          scanf("%d ", &g);
          e[f] = g;
        }
      }
      int* d = e;
      tab[z] = d;
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
      struct tuple_int_int * u = malloc (sizeof(u) );
      u->tuple_int_int_field_0=0;
      u->tuple_int_int_field_1=1;
      directions[i] = u;
    }
    else if (i == 1)
    {
      struct tuple_int_int * s = malloc (sizeof(s) );
      s->tuple_int_int_field_0=1;
      s->tuple_int_int_field_1=0;
      directions[i] = s;
    }
    else if (i == 2)
    {
      struct tuple_int_int * r = malloc (sizeof(r) );
      r->tuple_int_int_field_0=0;
      r->tuple_int_int_field_1=-1;
      directions[i] = r;
    }
    else if (i == 3)
    {
      struct tuple_int_int * q = malloc (sizeof(q) );
      q->tuple_int_int_field_0=-1;
      q->tuple_int_int_field_1=0;
      directions[i] = q;
    }
    else if (i == 4)
    {
      struct tuple_int_int * p = malloc (sizeof(p) );
      p->tuple_int_int_field_0=1;
      p->tuple_int_int_field_1=1;
      directions[i] = p;
    }
    else if (i == 5)
    {
      struct tuple_int_int * o = malloc (sizeof(o) );
      o->tuple_int_int_field_0=1;
      o->tuple_int_int_field_1=-1;
      directions[i] = o;
    }
    else if (i == 6)
    {
      struct tuple_int_int * l = malloc (sizeof(l) );
      l->tuple_int_int_field_0=-1;
      l->tuple_int_int_field_1=1;
      directions[i] = l;
    }
    else
    {
      struct tuple_int_int * k = malloc (sizeof(k) );
      k->tuple_int_int_field_0=-1;
      k->tuple_int_int_field_1=-1;
      directions[i] = k;
    }
  }
  int max_ = 0;
  int** m = read_int_matrix(20, 20);
  {
    int j;
    for (j = 0 ; j <= 7; j++)
    {
      struct tuple_int_int * h = directions[j];
      int dx = h->tuple_int_int_field_0;
      int dy = h->tuple_int_int_field_1;
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


