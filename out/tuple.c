#include<stdio.h>
#include<stdlib.h>

typedef struct tuple_int_int {
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
} tuple_int_int;

struct tuple_int_int * f(struct tuple_int_int * tuple_){
  struct tuple_int_int * c = tuple_;
  int a = c->tuple_int_int_field_0;
  int b = c->tuple_int_int_field_1;
  struct tuple_int_int * e = malloc (sizeof(e) );
  e->tuple_int_int_field_0=a + 1;
  e->tuple_int_int_field_1=b + 1;
  return e;
}

int main(void){
  struct tuple_int_int * g = malloc (sizeof(g) );
  g->tuple_int_int_field_0=0;
  g->tuple_int_int_field_1=1;
  struct tuple_int_int * t = f(g);
  struct tuple_int_int * d = t;
  int a = d->tuple_int_int_field_0;
  int b = d->tuple_int_int_field_1;
  printf("%d -- %d--\n", a, b);
  return 0;
}


