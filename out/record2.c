#include<stdio.h>
#include<stdlib.h>

struct toto;
typedef struct toto {
  int foo;
  int bar;
  int blah;
} toto;

struct toto * mktoto(int v1){
  struct toto * c = malloc (sizeof(c) );
  c->foo=v1;
  c->bar=0;
  c->blah=0;
  struct toto * t = c;
  return t;
}

int result(struct toto * t){
  t->blah ++;
  return t->foo + t->blah * t->bar + t->bar * t->foo;
}

int main(void){
  struct toto * t = mktoto(4);
  scanf("%d", &t->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t->blah);
  int a = result(t);
  printf("%d", a);
  int b = t->blah;
  printf("%d", b);
  return 0;
}


