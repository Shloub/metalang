#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

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
  int j, x, y, p, r, i;
  tuple_int_int * *directions = malloc( 8 * sizeof(tuple_int_int *));
  for (i = 0 ; i < 8; i++)
    if (i == 0)
  {
    tuple_int_int * c = [tuple_int_int alloc];
    c->tuple_int_int_field_0=0;
    c->tuple_int_int_field_1=1;
    directions[i] = c;
  }
  else if (i == 1)
  {
    tuple_int_int * d = [tuple_int_int alloc];
    d->tuple_int_int_field_0=1;
    d->tuple_int_int_field_1=0;
    directions[i] = d;
  }
  else if (i == 2)
  {
    tuple_int_int * e = [tuple_int_int alloc];
    e->tuple_int_int_field_0=0;
    e->tuple_int_int_field_1=-1;
    directions[i] = e;
  }
  else if (i == 3)
  {
    tuple_int_int * f = [tuple_int_int alloc];
    f->tuple_int_int_field_0=-1;
    f->tuple_int_int_field_1=0;
    directions[i] = f;
  }
  else if (i == 4)
  {
    tuple_int_int * g = [tuple_int_int alloc];
    g->tuple_int_int_field_0=1;
    g->tuple_int_int_field_1=1;
    directions[i] = g;
  }
  else if (i == 5)
  {
    tuple_int_int * h = [tuple_int_int alloc];
    h->tuple_int_int_field_0=1;
    h->tuple_int_int_field_1=-1;
    directions[i] = h;
  }
  else if (i == 6)
  {
    tuple_int_int * k = [tuple_int_int alloc];
    k->tuple_int_int_field_0=-1;
    k->tuple_int_int_field_1=1;
    directions[i] = k;
  }
  else
  {
    tuple_int_int * l = [tuple_int_int alloc];
    l->tuple_int_int_field_0=-1;
    l->tuple_int_int_field_1=-1;
    directions[i] = l;
  }
  int max0 = 0;
  int o = 20;
  int* *m = malloc( 20 * sizeof(int*));
  for (p = 0 ; p < 20; p++)
  {
    int *q = malloc( o * sizeof(int));
    for (r = 0 ; r < o; r++)
    {
      scanf("%d ", &q[r]);
    }
    m[p] = q;
  }
  for (j = 0 ; j <= 7; j++)
  {
    tuple_int_int * s = directions[j];
    int dx = s->tuple_int_int_field_0;
    int dy = s->tuple_int_int_field_1;
    for (x = 0 ; x <= 19; x++)
      for (y = 0 ; y <= 19; y++)
        max0 = max2_(max0, find(4, m, x, y, dx, dy));
  }
  printf("%d\n", max0);
  [pool drain];
  return 0;
}


