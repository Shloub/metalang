#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int max2(int a, int b){
  if (a > b)
    return a;
  else
    return b;
}

int** read_int_matrix(int x, int y){
  int z, e;
  int* *tab = malloc( y * sizeof(int*));
  for (z = 0 ; z < y; z++)
  {
    int *d = malloc( x * sizeof(int));
    for (e = 0 ; e < x; e++)
    {
      int f = 0;
      scanf("%d ", &f);
      d[e] = f;
    }
    int* c = d;
    tab[z] = c;
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
    tuple_int_int * s = [tuple_int_int alloc];
    s->tuple_int_int_field_0=0;
    s->tuple_int_int_field_1=1;
    directions[i] = s;
  }
  else if (i == 1)
  {
    tuple_int_int * r = [tuple_int_int alloc];
    r->tuple_int_int_field_0=1;
    r->tuple_int_int_field_1=0;
    directions[i] = r;
  }
  else if (i == 2)
  {
    tuple_int_int * q = [tuple_int_int alloc];
    q->tuple_int_int_field_0=0;
    q->tuple_int_int_field_1=-1;
    directions[i] = q;
  }
  else if (i == 3)
  {
    tuple_int_int * p = [tuple_int_int alloc];
    p->tuple_int_int_field_0=-1;
    p->tuple_int_int_field_1=0;
    directions[i] = p;
  }
  else if (i == 4)
  {
    tuple_int_int * o = [tuple_int_int alloc];
    o->tuple_int_int_field_0=1;
    o->tuple_int_int_field_1=1;
    directions[i] = o;
  }
  else if (i == 5)
  {
    tuple_int_int * l = [tuple_int_int alloc];
    l->tuple_int_int_field_0=1;
    l->tuple_int_int_field_1=-1;
    directions[i] = l;
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
    tuple_int_int * h = [tuple_int_int alloc];
    h->tuple_int_int_field_0=-1;
    h->tuple_int_int_field_1=-1;
    directions[i] = h;
  }
  int max_ = 0;
  int** m = read_int_matrix(20, 20);
  for (j = 0 ; j <= 7; j++)
  {
    tuple_int_int * g = directions[j];
    int dx = g->tuple_int_int_field_0;
    int dy = g->tuple_int_int_field_1;
    for (x = 0 ; x <= 19; x++)
      for (y = 0 ; y <= 19; y++)
        max_ = max2(max_, find(4, m, x, y, dx, dy));
  }
  printf("%d\n", max_);
  [pool drain];
  return 0;
}


