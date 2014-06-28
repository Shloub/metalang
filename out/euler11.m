#import <Foundation/Foundation.h>
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
  int c = 8;
  tuple_int_int * *directions = malloc( c * sizeof(tuple_int_int *));
  {
    int i;
    for (i = 0 ; i < c; i++)
      if (i == 0)
    {
      tuple_int_int * p = [tuple_int_int alloc];
      p->tuple_int_int_field_0=0;
      p->tuple_int_int_field_1=1;
      directions[i] = p;
    }
    else if (i == 1)
    {
      tuple_int_int * o = [tuple_int_int alloc];
      o->tuple_int_int_field_0=1;
      o->tuple_int_int_field_1=0;
      directions[i] = o;
    }
    else if (i == 2)
    {
      tuple_int_int * l = [tuple_int_int alloc];
      l->tuple_int_int_field_0=0;
      l->tuple_int_int_field_1=-1;
      directions[i] = l;
    }
    else if (i == 3)
    {
      tuple_int_int * k = [tuple_int_int alloc];
      k->tuple_int_int_field_0=-1;
      k->tuple_int_int_field_1=0;
      directions[i] = k;
    }
    else if (i == 4)
    {
      tuple_int_int * h = [tuple_int_int alloc];
      h->tuple_int_int_field_0=1;
      h->tuple_int_int_field_1=1;
      directions[i] = h;
    }
    else if (i == 5)
    {
      tuple_int_int * g = [tuple_int_int alloc];
      g->tuple_int_int_field_0=1;
      g->tuple_int_int_field_1=-1;
      directions[i] = g;
    }
    else if (i == 6)
    {
      tuple_int_int * f = [tuple_int_int alloc];
      f->tuple_int_int_field_0=-1;
      f->tuple_int_int_field_1=1;
      directions[i] = f;
    }
    else
    {
      tuple_int_int * e = [tuple_int_int alloc];
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
      tuple_int_int * d = directions[j];
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
  [pool drain];
  return 0;
}


