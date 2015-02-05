#include <stdio.h>
#include <stdlib.h>

typedef struct tuple_int_int {
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
} tuple_int_int;

int main(void){
  int i, e, d;
  for (i = 1 ; i <= 3; i++)
  {
    scanf("%d %d ", &d, &e);
    struct tuple_int_int * f = malloc (sizeof(f) );
    f->tuple_int_int_field_0=d;
    f->tuple_int_int_field_1=e;
    int a = f->tuple_int_int_field_0;
    int b = f->tuple_int_int_field_1;
    printf("a = %d b = %d\n", a, b);
  }
  return 0;
}


