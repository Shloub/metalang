#include<stdio.h>
#include<stdlib.h>

typedef struct tuple_int_int {
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
} tuple_int_int;

struct tuple_int_int * f(struct tuple_int_int * tuple0){
  struct tuple_int_int * e = malloc (sizeof(e) );
  e->tuple_int_int_field_0=tuple0->tuple_int_int_field_0 + 1;
  e->tuple_int_int_field_1=tuple0->tuple_int_int_field_1 + 1;
  return e;
}

int main(void){
  struct tuple_int_int * g = malloc (sizeof(g) );
  g->tuple_int_int_field_0=0;
  g->tuple_int_int_field_1=1;
  struct tuple_int_int * t = f(g);
  printf("%d -- %d--\n", t->tuple_int_int_field_0, t->tuple_int_int_field_1);
  return 0;
}


