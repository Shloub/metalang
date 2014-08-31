#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int max2_(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int** read_int_matrix(int x, int y){
  int z, e, f;
  int* *tab = malloc( y * sizeof(int*));
  for (z = 0 ; z < y; z++)
  {
    int *d = malloc( x * sizeof(int));
    for (e = 0 ; e < x; e++)
    {
      scanf("%d ", &f);
      d[e] = f;
    }
    tab[z] = d;
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

@interface tuple_int_int : NSObject
{
  @public int tuple_int_int_field_0;
  @public int tuple_int_int_field_1;
}
@end
@implementation tuple_int_int 
@end

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int j, x, y, i;
  tuple_int_int * *directions = malloc( 8 * sizeof(tuple_int_int *));
  for (i = 0 ; i < 8; i++)
    if (i == 0)
  {
    tuple_int_int * v = [tuple_int_int alloc];
    v->tuple_int_int_field_0=0;
    v->tuple_int_int_field_1=1;
    directions[i] = v;
  }
  else if (i == 1)
  {
    tuple_int_int * u = [tuple_int_int alloc];
    u->tuple_int_int_field_0=1;
    u->tuple_int_int_field_1=0;
    directions[i] = u;
  }
  else if (i == 2)
  {
    tuple_int_int * s = [tuple_int_int alloc];
    s->tuple_int_int_field_0=0;
    s->tuple_int_int_field_1=-1;
    directions[i] = s;
  }
  else if (i == 3)
  {
    tuple_int_int * r = [tuple_int_int alloc];
    r->tuple_int_int_field_0=-1;
    r->tuple_int_int_field_1=0;
    directions[i] = r;
  }
  else if (i == 4)
  {
    tuple_int_int * q = [tuple_int_int alloc];
    q->tuple_int_int_field_0=1;
    q->tuple_int_int_field_1=1;
    directions[i] = q;
  }
  else if (i == 5)
  {
    tuple_int_int * p = [tuple_int_int alloc];
    p->tuple_int_int_field_0=1;
    p->tuple_int_int_field_1=-1;
    directions[i] = p;
  }
  else if (i == 6)
  {
    tuple_int_int * o = [tuple_int_int alloc];
    o->tuple_int_int_field_0=-1;
    o->tuple_int_int_field_1=1;
    directions[i] = o;
  }
  else
  {
    tuple_int_int * l = [tuple_int_int alloc];
    l->tuple_int_int_field_0=-1;
    l->tuple_int_int_field_1=-1;
    directions[i] = l;
  }
  int max_ = 0;
  int** m = read_int_matrix(20, 20);
  for (j = 0 ; j <= 7; j++)
  {
    tuple_int_int * k = directions[j];
    int dx = k->tuple_int_int_field_0;
    int dy = k->tuple_int_int_field_1;
    for (x = 0 ; x <= 19; x++)
      for (y = 0 ; y <= 19; y++)
      {
        int h = find(4, m, x, y, dx, dy);
        int g = max2_(max_, h);
        max_ = g;
    }
  }
  printf("%d\n", max_);
  [pool drain];
  return 0;
}


