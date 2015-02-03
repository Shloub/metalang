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
  int j, x, y, o, q, i;
  tuple_int_int * *directions = malloc( 8 * sizeof(tuple_int_int *));
  for (i = 0 ; i < 8; i++)
    if (i == 0)
  {
    tuple_int_int * bh = [tuple_int_int alloc];
    bh->tuple_int_int_field_0=0;
    bh->tuple_int_int_field_1=1;
    directions[i] = bh;
  }
  else if (i == 1)
  {
    tuple_int_int * bg = [tuple_int_int alloc];
    bg->tuple_int_int_field_0=1;
    bg->tuple_int_int_field_1=0;
    directions[i] = bg;
  }
  else if (i == 2)
  {
    tuple_int_int * bf = [tuple_int_int alloc];
    bf->tuple_int_int_field_0=0;
    bf->tuple_int_int_field_1=-1;
    directions[i] = bf;
  }
  else if (i == 3)
  {
    tuple_int_int * be = [tuple_int_int alloc];
    be->tuple_int_int_field_0=-1;
    be->tuple_int_int_field_1=0;
    directions[i] = be;
  }
  else if (i == 4)
  {
    tuple_int_int * bd = [tuple_int_int alloc];
    bd->tuple_int_int_field_0=1;
    bd->tuple_int_int_field_1=1;
    directions[i] = bd;
  }
  else if (i == 5)
  {
    tuple_int_int * bc = [tuple_int_int alloc];
    bc->tuple_int_int_field_0=1;
    bc->tuple_int_int_field_1=-1;
    directions[i] = bc;
  }
  else if (i == 6)
  {
    tuple_int_int * bb = [tuple_int_int alloc];
    bb->tuple_int_int_field_0=-1;
    bb->tuple_int_int_field_1=1;
    directions[i] = bb;
  }
  else
  {
    tuple_int_int * ba = [tuple_int_int alloc];
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
    tuple_int_int * w = directions[j];
    int dx = w->tuple_int_int_field_0;
    int dy = w->tuple_int_int_field_1;
    for (x = 0 ; x <= 19; x++)
      for (y = 0 ; y <= 19; y++)
        max0 = max2_(max0, find(4, m, x, y, dx, dy));
  }
  printf("%d\n", max0);
  [pool drain];
  return 0;
}


