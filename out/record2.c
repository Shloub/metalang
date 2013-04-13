#include<stdio.h>
#include<stdlib.h>

struct toto;
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
  t->blah = t->blah + 1;
  return t->foo + t->blah * t->bar + t->bar * t->foo;
}

int main(void){
  struct toto * t = mktoto(4);
  scanf("%d", &t->bar);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &t->blah);
  int a = result(t);
  printf("%d", a);
  int b = t->blah;
  printf("%d", b);
  return 0;
}


