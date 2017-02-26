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
int main(void) {
    int d, c, bar_;
    scanf("%d %d %d ", &bar_, &c, &d);
    struct tuple_int_int * e = malloc(sizeof(tuple_int_int));
    e->tuple_int_int_field_0 = c;
    e->tuple_int_int_field_1 = d;
    struct toto * t = malloc(sizeof(toto));
    t->foo = e;
    t->bar = bar_;
    struct tuple_int_int * f = t->foo;
    int a = f->tuple_int_int_field_0;
    int b = f->tuple_int_int_field_1;
    printf("%d %d %d\n", a, b, t->bar);
    return 0;
}


