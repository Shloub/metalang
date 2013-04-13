#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

typedef enum foo_t {
  Foo,
  Bar,
  Blah
} foo_t;
int main(void){
  foo_t foo_val = Foo;
  return 0;
}


