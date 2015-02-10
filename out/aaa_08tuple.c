#include <stdio.h>
#include <stdlib.h>

typedef struct tuple_int_int {
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
} tuple_int_int;

typedef struct toto {
  struct tuple_int_int * foo;
  int bar;
} toto;

int main(void){
  int g, f, bar_;
  scanf("%d %d %d ", &bar_, &f, &g);
  struct tuple_int_int * i = malloc (sizeof(i) );
  i->tuple_int_int_field_0=f;
  i->tuple_int_int_field_1=g;
  struct toto * t = malloc (sizeof(t) );
  t->foo=i;
  t->bar=bar_;
  struct tuple_int_int * h = t->foo;
  int a = h->tuple_int_int_field_0;
  int b = h->tuple_int_int_field_1;
  printf("%d %d %d\n", a, b, t->bar);
  return 0;
}


