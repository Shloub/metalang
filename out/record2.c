#include <stdio.h>
#include <stdlib.h>

typedef struct toto {
  int foo;
  int bar;
  int blah;
} toto;

struct toto * mktoto(int v1){
  struct toto * t = malloc (sizeof(t) );
  t->foo=v1;
  t->bar=0;
  t->blah=0;
  return t;
}

int result(struct toto * t){
  t->blah++;
  return t->foo + t->blah * t->bar + t->bar * t->foo;
}

int main(void){
  struct toto * t = mktoto(4);
  scanf("%d %d", &t->bar, &t->blah);
  printf("%d", result(t));
  return 0;
}


